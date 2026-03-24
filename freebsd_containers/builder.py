"""Builder orchestrator — wires all modules into the full build pipeline.

This module replaces the monolithic ``main()`` function in the original
``build.py``.  It drives the complete generation workflow:

1. Load version matrix from ``versions.json``
2. Optionally fetch fresh image digests from Docker Hub
3. Merge digests into the OS version matrix
4. Iterate over (OS version x project x project version) combinations
5. Generate tags, render templates, CI/CD scripts, and documentation
"""

from __future__ import annotations

import datetime as dt
import json
import shutil
from typing import TYPE_CHECKING, Any

from freebsd_containers.cicd import render_cicd_scripts, resolve_cicd_source_paths
from freebsd_containers.config import ARCH_MAP, RegistryConfig, get_registry
from freebsd_containers.digests import fetch_digests, merge_digests_into_os_versions
from freebsd_containers.docs import render_docs, render_mkdocs_yml, scaffold_docs
from freebsd_containers.tags import TagInput, TagResult, generate_tags
from freebsd_containers.templates import (
    create_j2_env,
    group_templates_by_project,
    render_project_templates,
    translate_upstream_docs,
)
from freebsd_containers.versions import (
    OsVersion,
    ProjectVersion,
    load_versions,
    parse_os_version,
    parse_project_version,
)

if TYPE_CHECKING:
    from pathlib import Path


def build(
    *,
    base_dir: Path,
    build_dir: Path | None = None,
    registry_id: str = "local",
    update_digests: bool = False,
    project_filter: str | None = None,
) -> None:
    """Run the full build pipeline.

    Args:
        base_dir: Project root directory containing ``versions.json``,
            ``templates/``, and ``upstreams/``.
        build_dir: Output directory.  Defaults to ``{base_dir}/build``.
        registry_id: Registry key (e.g. ``"local"``, ``"github"``).
        update_digests: If ``True``, fetch fresh digests from Docker Hub.
        project_filter: If set, only generate output for this project.
    """
    base_dir = base_dir.resolve()
    if build_dir is None:
        build_dir = base_dir / "build"

    # Load version matrix
    vm = load_versions(base_dir / "versions.json")

    # Optionally refresh digests
    if update_digests or "image_digests" not in vm.__dict__:
        fresh = fetch_digests(ARCH_MAP)
        vm.image_digests = fresh
        # Write back to versions.json
        versions_file = base_dir / "versions.json"
        with versions_file.open() as f:
            raw = json.load(f)
        raw["image_digests"] = fresh
        versions_file.write_text(json.dumps(raw, indent=2, sort_keys=False))

    # Merge digests into os_versions
    merge_digests_into_os_versions(vm.os_versions, vm.image_digests)

    # Set up build environment
    registry = get_registry(registry_id, vm.registries)
    docs_registry = get_registry("github", vm.registries)
    push_registries = {k: v for k, v in vm.registries.items() if k != "local"}

    # Set up Jinja2
    j2_env = create_j2_env(base_dir)
    raw_templates = j2_env.list_templates(extensions="j2")
    grouped = group_templates_by_project(raw_templates)

    # Clean and create build directories
    if build_dir.exists():
        shutil.rmtree(build_dir)

    build_images_dir = build_dir / "images"
    build_docs_dir = build_dir / "docs"
    build_scripts_dir = build_dir / "ci_cd"

    # Scaffold docs
    scaffold_docs(base_dir, build_docs_dir)

    # Derive reference versions
    ref_os_major_minor = vm.reference_os_major_minor_version

    os_name = "freebsd"
    project_context: dict[str, Any] = {}
    base_dir_part_count = len(base_dir.parts)

    # Main iteration loop
    for os_major, ovmj_details in vm.os_versions.items():
        for os_minor_key in ovmj_details:
            ov = parse_os_version(os_major, os_minor_key)
            os_security_patch = vm.os_security_patches.get(ov.major_minor)

            for project, p_details in vm.projects.items():
                if project_filter and project != project_filter:
                    continue

                # Derive project alias and tag OS name
                if p_details["type"] == "os_variant":
                    project_alias = f"{os_name}-{project}"
                    tag_os_name = ""
                else:
                    project_alias = project
                    tag_os_name = os_name

                # Set up upstream docs (once per project)
                _setup_upstream_docs(base_dir, project, project_alias)

                # Build project context (once per project)
                reference_project_version = p_details["reference_project_version"]
                if project not in project_context:
                    _init_project_context(
                        project_context,
                        project,
                        project_alias,
                        p_details,
                        ref_os_major_minor,
                        base_dir,
                    )

                for version_str in p_details["versions"]:
                    pv = parse_project_version(version_str)

                    # Determine build image directory
                    image_dir = (
                        build_images_dir
                        / f"{ov.major}.{ov.short_minor}"
                        / project
                        / pv.version_dir
                    )
                    image_dir.parent.mkdir(parents=True, exist_ok=True)

                    # Determine base image digest
                    if p_details["type"] == "os_variant":
                        base_image_digest = ovmj_details[ov.minor_and_patch][
                            version_str
                        ]["index"]
                    else:
                        base_image_digest = None

                    # Determine if image should be built
                    build_image = _should_build_image(
                        p_details, project, version_str, os_name
                    )

                    # Generate tags
                    tag_input = TagInput(
                        project_alias=project_alias,
                        tag_os_name=tag_os_name,
                        project_major=pv.major,
                        project_minor=pv.minor,
                        project_patch=pv.patch,
                        project_major_minor=pv.major_minor,
                        project_major_minor_patch=pv.major_minor_patch,
                        os_major=ov.major,
                        os_minor=ov.minor,
                        os_major_minor=ov.major_minor,
                        reference_project_version=reference_project_version,
                        os_ref_minor_for_major=vm.os_reference_versions.get(
                            ov.major, ""
                        ),
                        reference_os_major_minor=ref_os_major_minor,
                    )
                    tag_result = generate_tags(tag_input)

                    # Build template context
                    tag_last_pushed = vm.image_digests[ov.major][ov.minor_and_patch][
                        "tag_last_pushed"
                    ]
                    context = _build_context(
                        ov=ov,
                        pv=pv,
                        project=project,
                        project_alias=project_alias,
                        tag_result=tag_result,
                        os_security_patch=os_security_patch,
                        reference_project_version=reference_project_version,
                        registry=registry,
                        push_registries=push_registries,
                        tag_last_pushed=tag_last_pushed,
                        base_image_digest=base_image_digest,
                        build_image=build_image,
                        build_environment=vm.build_environment,
                        p_details=p_details,
                    )

                    # Store in project context
                    project_context[project]["images"][tag_result.full_image_tag] = (
                        context
                    )

                    # Copy non-template files
                    template_dir = base_dir / "templates" / project
                    shutil.copytree(
                        template_dir,
                        image_dir,
                        ignore=shutil.ignore_patterns("*.j2", "ci_cd", "docs"),
                    )

                    # Render CI/CD scripts
                    if build_image:
                        render_cicd_scripts(
                            env=j2_env,
                            grouped=grouped,
                            project=project,
                            context=context,
                            image_dir=image_dir,
                            scripts_dir=build_scripts_dir,
                            os_name=os_name,
                            os_major_minor_version=ov.major_minor,
                            project_alias=project_alias,
                            base_dir_part_count=base_dir_part_count,
                        )

                    # Render project templates
                    render_project_templates(
                        j2_env, grouped, project, context, image_dir
                    )

                    # Update E-tag context for docs
                    if (
                        ov.major_minor == ref_os_major_minor
                        and pv.major_minor == reference_project_version
                    ):
                        _update_docs_context(
                            project_context,
                            project,
                            pv,
                            tag_result,
                            project_alias,
                            tag_os_name,
                            docs_registry,
                        )

    # Render docs
    render_mkdocs_yml(j2_env, project_context, build_dir / "mkdocs.yml")
    for project, ctx in project_context.items():
        render_docs(
            env=j2_env,
            grouped=grouped,
            project=project,
            context=ctx,
            base_dir=base_dir,
            docs_dir=build_docs_dir,
        )


def _setup_upstream_docs(
    base_dir: Path,
    project: str,
    project_alias: str,
) -> None:
    """Copy and translate upstream Docker docs for a project."""
    template_dir = base_dir / "templates" / project
    template_dir.mkdir(parents=True, exist_ok=True)
    ci_cd_dir = template_dir / "ci_cd"
    ci_cd_dir.mkdir(parents=True, exist_ok=True)
    docs_dir = template_dir / "docs"
    docs_freebsd_dir = docs_dir / "freebsd"
    docs_freebsd_dir.mkdir(parents=True, exist_ok=True)
    docs_upstream_dir = docs_dir / "upstream"
    (docs_freebsd_dir / "examples").mkdir(parents=True, exist_ok=True)

    docker_docs_dir = base_dir / "upstreams" / "docs"
    docker_docs_project_dir = docker_docs_dir / project
    if not docker_docs_project_dir.exists():
        return

    if docs_upstream_dir.exists():
        shutil.rmtree(docs_upstream_dir)
    shutil.copytree(docker_docs_project_dir, docs_upstream_dir)

    # Copy standard files
    for _file in [
        "license.md",
        "logo.png",
        "metadata.json",
        "README-short.txt",
    ]:
        dest = _file.replace("-short", "")
        if not (docs_freebsd_dir / dest).exists():
            src = docs_upstream_dir / _file
            if src.exists():
                shutil.copy(src, docs_freebsd_dir / dest)

    # Handle compose
    compose_src = docs_upstream_dir / "compose.yaml"
    if compose_src.exists():
        compose_content = (
            "```containerfile\n" + compose_src.read_text(encoding="utf-8") + "\n```"
        )
        if not (docs_freebsd_dir / "compose.yaml").exists():
            shutil.copy(compose_src, docs_freebsd_dir / "compose.yaml")
    else:
        compose_content = ""

    # Translate content.md
    content_src = docs_upstream_dir / "content.md"
    if content_src.exists():
        content = content_src.read_text(encoding="utf-8")
        translated = translate_upstream_docs(
            content,
            project_alias=project_alias,
            compose_content=compose_content,
        )
        translated_file = docs_freebsd_dir / "content.md"
        if translated_file.exists():
            translated_file = docs_upstream_dir / "translated_content.md"
        translated_file.write_text(translated, encoding="utf-8")


def _init_project_context(
    project_context: dict[str, Any],
    project: str,
    project_alias: str,
    p_details: dict[str, Any],
    ref_os_major_minor: str,
    base_dir: Path,
) -> None:
    """Initialise the project context for a new project."""
    reference_project_version = p_details["reference_project_version"]
    reference_path = (
        f"images/{ref_os_major_minor}/{p_details['slug']}/{reference_project_version}"
    )
    template_path = f"templates/{project}"

    ci_cd_source_paths = resolve_cicd_source_paths(base_dir, project)

    template_dir = base_dir / "templates" / project
    usage_file = template_dir / "docs" / "freebsd" / "content.md"
    compose_file = template_dir / "docs" / "freebsd" / "compose.yaml"

    project_context[project] = {
        "project_alias": project_alias,
        "details": {
            **p_details,
            "usage_file": usage_file,
            "usage_file_available": usage_file.exists(),
            "compose_file": compose_file,
            "compose_file_available": compose_file.exists(),
            "license_file_available": (template_dir / "LICENSE").exists(),
        },
        "images": {},
        "reference_os_major_minor_version": ref_os_major_minor,
        "reference_path": reference_path,
        "template_path": template_path,
        "ci_cd_source_paths": ci_cd_source_paths,
    }


def _should_build_image(
    p_details: dict[str, Any],
    project: str,
    version_str: str,
    os_name: str,
) -> bool:
    """Determine whether an image should actually be built."""
    if (
        p_details["type"] == "os_variant"
        and os_name == "freebsd"
        and version_str in ("static", "dynamic")
    ):
        return False
    return not (project in ("python", "uv") and version_str != "3.11")


def _build_context(
    *,
    ov: OsVersion,
    pv: ProjectVersion,
    project: str,
    project_alias: str,
    tag_result: TagResult,
    os_security_patch: str | None,
    reference_project_version: str,
    registry: RegistryConfig,
    push_registries: dict[str, dict[str, Any]],
    tag_last_pushed: str,
    base_image_digest: str | None,
    build_image: bool,
    build_environment: dict[str, Any],
    p_details: dict[str, Any],
) -> dict[str, Any]:
    """Build the template rendering context for one image."""
    return {
        "os_major_version": ov.major,
        "os_minor_and_patch_version": ov.minor_and_patch,
        "os_minor_version": ov.minor,
        "os_patch_version": ov.patch,
        "short_os_minor_version": ov.short_minor,
        "os_minor_version_digit": ov.minor_digit,
        "os_security_patch": os_security_patch,
        "project_version": pv.raw,
        "project": project,
        "project_alias": project_alias,
        "project_major_version": pv.major,
        "project_minor_version": pv.minor,
        "project_major_minor_version": pv.major_minor,
        "project_major_minor_patch_version": pv.major_minor_patch,
        "project_patch_version": pv.patch,
        "project_port_revision": pv.port_revision,
        "image_tags": tag_result.image_tags,
        "supported_tags": tag_result.supported_tags,
        "reference_project_version": reference_project_version,
        "registry": {
            "name": registry.name,
            "username": registry.username,
            "project": registry.project,
        },
        "push_registries": push_registries,
        "tag_last_pushed": dt.datetime.fromisoformat(tag_last_pushed).strftime(
            "%Y%m%d%H%M%S%z"
        ),
        "full_image_tag": tag_result.full_image_tag,
        "base_image_digest": base_image_digest,
        "build_image": build_image,
        "build_environment": build_environment,
        "extra": p_details["context"],
    }


def _update_docs_context(
    project_context: dict[str, Any],
    project: str,
    pv: ProjectVersion,
    tag_result: TagResult,
    project_alias: str,
    tag_os_name: str,
    docs_registry: RegistryConfig,
) -> None:
    """Update project context with docs-specific reference tags (E-tag)."""
    details = project_context[project]["details"]
    details["project_major_minor_patch_version"] = pv.major_minor_patch
    details["reference_full_image_tag"] = tag_result.full_image_tag

    min_tag = f"{project_alias}:{pv.major}-{tag_os_name}".strip("-")
    details["reference_min_image_tag"] = min_tag

    docs_prefix = docs_registry.prefix
    details["docs_reference_full_image_tag"] = (
        f"{docs_prefix}{tag_result.full_image_tag}"
    )
    details["docs_reference_min_image_tag"] = f"{docs_prefix}{min_tag}"
