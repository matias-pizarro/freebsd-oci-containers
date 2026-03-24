"""CI/CD script generation for container image builds.

Handles rendering of per-image CI/CD scripts (build, test, push,
run_pipeline) and creation of aggregation scripts grouped by OS version
and by project.
"""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from pathlib import Path

    import jinja2

_SCRIPT_IDS = ("build", "test", "push", "run_pipeline")

_AGGREGATION_HEADER = """#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

"""


def resolve_cicd_source_paths(
    base_dir: Path,
    project: str,
) -> dict[str, str]:
    """Resolve CI/CD template paths: project-specific if it exists, else shared.

    Args:
        base_dir: Project root directory.
        project: Project name.

    Returns:
        ``{script_id: template_path}`` mapping for build, test, push.
    """
    paths: dict[str, str] = {}
    for script_id in ("build", "test", "push"):
        project_script = (
            base_dir / "templates" / project / "ci_cd" / f"{script_id}.sh.j2"
        )
        if project_script.exists():
            paths[script_id] = f"{project}/ci_cd/{script_id}.sh.j2"
        else:
            paths[script_id] = f"ci_cd/{script_id}.sh.j2"
    return paths


def render_cicd_scripts(
    *,
    env: jinja2.Environment,
    grouped: dict[str, dict[str, Path]],
    project: str,
    context: dict[str, Any],
    image_dir: Path,
    scripts_dir: Path,
    os_name: str,
    os_major_minor_version: str,
    project_alias: str,
    base_dir_part_count: int,
) -> None:
    """Render CI/CD scripts for one image and append to aggregation scripts.

    Creates per-image scripts in ``{image_dir}/ci_cd/`` and appends
    references to aggregation scripts in ``{scripts_dir}/by_os_version/``
    and ``{scripts_dir}/by_project/``.

    Args:
        env: Jinja2 environment.
        grouped: Templates grouped by project.
        project: Project name.
        context: Template rendering context.
        image_dir: Build output directory for this image.
        scripts_dir: Top-level CI/CD scripts directory.
        os_name: OS name (e.g. ``"freebsd"``).
        os_major_minor_version: OS version string (e.g. ``"14.3"``).
        project_alias: Image name.
        base_dir_part_count: Number of path components in the project root.
    """
    cicd_dir = image_dir / "ci_cd"
    cicd_dir.mkdir(parents=True, exist_ok=True)

    by_os_dir = scripts_dir / "by_os_version" / f"{os_name}{os_major_minor_version}"
    by_os_dir.mkdir(parents=True, exist_ok=True)
    by_proj_dir = scripts_dir / "by_project" / project_alias
    by_proj_dir.mkdir(parents=True, exist_ok=True)

    for script_id in _SCRIPT_IDS:
        # Resolve template: project-specific or shared default
        default_template = env.get_template(f"ci_cd/{script_id}.sh.j2")
        if (
            project in grouped
            and f"{project}/ci_cd/{script_id}.sh.j2" in grouped[project]
        ):
            template = env.get_template(f"{project}/ci_cd/{script_id}.sh.j2")
        else:
            template = default_template

        script_file = cicd_dir / f"{script_id}.sh"
        script_file.write_text(template.render(context))
        script_file.chmod(0o755)

        # Append to aggregation scripts
        line = "/".join(script_file.absolute().parts[base_dir_part_count:])
        for target in (
            by_os_dir / f"{script_id}.sh",
            by_proj_dir / f"{script_id}.sh",
        ):
            if not target.exists():
                target.write_text(_AGGREGATION_HEADER)
                target.chmod(0o755)
            with target.open("a") as f:
                f.write(line + "\n")
