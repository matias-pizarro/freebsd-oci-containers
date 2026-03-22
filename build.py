#!/usr/bin/env -S uv run --script

import datetime as dt
import json
import pathlib
import re
import shutil

import jinja2 as j2
import requests

"""
This is n initial iteration aimed at identifying base components and logic.
Once this is done it needs to be divided in functions, objects and possibly
modules as well. It then needs to be documented and define tests.

"""

base_dir = pathlib.Path(__file__).resolve().parent
base_dir_part_count = len(base_dir.parts)
translated_archs = {"amd64": "amd64", "arm64": "aarch64", }
update_base_image_hashes = False
registry_id = "local"
# registry_id = "github"

dollar_prompt_pattern = re.compile(r"\$ ")
docker_pattern = re.compile(r'\bdocker\b')
compose_pattern = re.compile(r'#* *%%COMPOSE%%')
image_pattern = re.compile(r'%%IMAGE%%')
logo_pattern = re.compile(r'%%LOGO%%')
hash_pattern = re.compile(r"(\#+ )")
hash_replacement_pattern = '#\\1'
replacement_pattern = r'ALERT \\1'

def main():
    j2_env = j2.Environment(
        loader=j2.FileSystemLoader(base_dir / "templates"),
        autoescape=j2.select_autoescape()
    )
    raw_templates_list = j2_env.list_templates(extensions="j2")
    templates_list = {}
    for file_stub in raw_templates_list:
        _file = pathlib.Path(file_stub)
        parent_as_str = str(_file.parent)
        project = parent_as_str if parent_as_str == "." else _file.parts[0]
        if project not in templates_list:
            templates_list[project] = {}
        templates_list[project][file_stub] = _file

    from pprint import pprint
    pprint(templates_list)

    build_dir = base_dir / "build"
    build_images_dir = build_dir / "images"
    build_docs_dir = build_dir / "docs"
    build_scripts_dir = build_dir / "ci_cd"
    versions_file = base_dir / "versions.json"
    upstream_dir = base_dir / "upstreams"
    docker_docs_dir = upstream_dir / "docs"

    with open(versions_file, 'r') as _file:
        versions = json.load(_file)

    if update_base_image_hashes or "image_digests" not in versions:
        digests = {}

        for image_version in ["static", "dynamic", "runtime"]:
            url = f"https://hub.docker.com/v2/repositories/freebsd/freebsd-{image_version}/tags?page=1&page_size=300"
            response = requests.get(url)

            if response.status_code == 200:
                try:
                    data = response.json()
                except ValueError as e:
                    print(f"Failed to decode JSON: {e}")
            else:
                print(f"HTTP Error: {response.status_code}")

            for tag in data["results"]:
                os_version = tag["name"]
                os_major_version, short_os_minor_version = os_version.split('.', 1)
                os_minor_version = "snapshot" if short_os_minor_version == "snap" else short_os_minor_version
                if os_major_version not in digests:
                    digests[os_major_version] = {}
                if os_minor_version not in digests[os_major_version]:
                    digests[os_major_version][os_minor_version] = {}
                if "tag_last_pushed" not in digests[os_major_version][os_minor_version]:
                    digests[os_major_version][os_minor_version]["tag_last_pushed"] = tag["tag_last_pushed"]
                if image_version not in digests[os_major_version][os_minor_version]:
                    digests[os_major_version][os_minor_version][image_version] = {}
                digests[os_major_version][os_minor_version][image_version]["index"] = tag["digest"]
                for image in tag["images"]:
                    arch = translated_archs[image["architecture"]]
                    digest = image["digest"]
                    digests[os_major_version][os_minor_version][image_version][arch] = digest
        versions["image_digests"] = json.loads(json.dumps(digests, sort_keys=True))
        versions_file.write_text(json.dumps(versions, indent=2, sort_keys=False))

    build_environment = versions["build_environment"].copy()
    os_versions = versions["os_versions"].copy()
    image_digests = versions["image_digests"].copy()
    projects = versions["projects"].copy()
    registry = versions["registries"][registry_id].copy()
    push_registries = versions["registries"].copy()
    del push_registries['local']
    os_reference_versions = versions["os_reference_versions"].copy()
    os_security_patches = versions["os_security_patches"].copy()

    for os_major_version, ovmj_details in os_versions.items():
        for os_minor_version, ovmi_details in ovmj_details.items():
            for image_version, iv_details in ovmi_details.items():
                # print(f"{os_major_version}.{os_minor_version}-{image_version}")
                try:
                    os_versions[os_major_version][os_minor_version][image_version] = image_digests[os_major_version][os_minor_version][image_version]
                except KeyError:
                    pass

    os_name = "freebsd"
    tags = []
    project_context = {}
    if build_dir.exists():
        shutil.rmtree(build_dir)

    # Prepare docs scaffolding
    template_docs_dir = base_dir / "templates" / "oci_containers_mkdocs"
    build_docs_dir.parent.mkdir(parents=True,exist_ok=True)
    shutil.copytree(template_docs_dir / "docs", build_docs_dir, ignore=shutil.ignore_patterns('*.j2'))

    reference_os_major_version = os_reference_versions["reference_os_major_version"]
    reference_os_minor_version = os_reference_versions[reference_os_major_version]
    reference_os_major_minor_version = f"{reference_os_major_version}.{reference_os_minor_version}"
    for os_major_version, ovmj_details in os_versions.items():
        for os_minor_version, ovmi_details in ovmj_details.items():
            omv_parts = os_minor_version.split(".")
            os_minor_version = omv_parts[0]
            os_patch_version = omv_parts[1] if len(omv_parts) > 1 else ""
            os_minor_and_patch_version = os_minor_version if os_patch_version == "" else f"{os_minor_version}.{os_patch_version}"
            short_os_minor_version = "snap" if os_minor_version == "snapshot" else os_minor_version
            os_minor_version_digit = "0" if os_minor_version == "snapshot" else os_minor_version
            os_major_minor_version = f"{os_major_version}.{os_minor_version}"
            os_security_patch = os_security_patches[os_major_minor_version] if os_major_minor_version in os_security_patches else None
            for project, p_details in projects.items():
                if p_details["type"] == 'os_variant':
                    project_alias = f"{os_name}-{project}"
                    tag_os_name = ""
                else:
                    project_alias = project
                    tag_os_name = os_name

                template_dir = base_dir / "templates" / project
                template_dir.mkdir(parents=True,exist_ok=True)
                ci_cd_dir = template_dir / "ci_cd"
                ci_cd_dir.mkdir(parents=True,exist_ok=True)
                docs_dir = template_dir / "docs"
                docs_freebsd_dir = docs_dir / "freebsd"
                docs_freebsd_dir.mkdir(parents=True,exist_ok=True)
                docs_upstream_dir = docs_dir / "upstream"
                example_dir = docs_freebsd_dir / "examples"
                example_dir.mkdir(parents=True,exist_ok=True)
                docker_docs_project_dir = docker_docs_dir / project
                if docker_docs_project_dir.exists():
                    if docs_upstream_dir.exists():
                        shutil.rmtree(docs_upstream_dir)
                    shutil.copytree(docker_docs_project_dir, docs_upstream_dir)
                    for _file in ["license.md", "logo.png", "metadata.json", "README-short.txt"]:
                        _file_dest = _file.replace("-short", "")
                        if not (docs_freebsd_dir / _file).exists():
                            shutil.copy(docs_upstream_dir / _file, docs_freebsd_dir / _file_dest)

                    if (docs_upstream_dir / "compose.yaml").exists():
                        compose_content = '```containerfile\n' + (docs_upstream_dir / "compose.yaml").read_text(encoding='utf-8') + '\n```'
                        if not (docs_freebsd_dir / "compose.yaml").exists():
                            shutil.copy(docs_upstream_dir / "compose.yaml", docs_freebsd_dir / "compose.yaml")
                    else:
                        compose_content = ""

                    if (docs_upstream_dir / "content.md").exists():
                        content = (docs_upstream_dir / "content.md").read_text(encoding='utf-8')
                        translated_content = re.sub(
                            hash_pattern, hash_replacement_pattern, content
                        )
                        translated_content = re.sub(
                            image_pattern, project_alias, translated_content
                        )
                        translated_content = re.sub(
                            logo_pattern, '![Project logo](logo.png)', translated_content
                        )
                        translated_content = re.sub(
                            compose_pattern, compose_content, translated_content
                        )
                        translated_content = re.sub(
                            dollar_prompt_pattern, "", translated_content
                        )
                        translated_content = re.sub(
                            docker_pattern, "podman", translated_content
                        )
                        translated_content_file = (docs_freebsd_dir / "content.md")
                        if translated_content_file.exists():
                            translated_content_file = (docs_upstream_dir / "translated_content.md")
                        translated_content_file.write_text(
                            translated_content, encoding='utf-8'
                        )
                reference_project_version = p_details["reference_project_version"]
                if project not in project_context:
                    reference_path = f"images/{reference_os_major_minor_version}/{p_details['slug']}/{reference_project_version}"
                    project_context[project] = {
                        "project_alias": project_alias,
                        "details": p_details,
                        "images": {},
                        "reference_os_major_minor_version": reference_os_major_minor_version,
                        "reference_path": reference_path,
                    }
                    usage_file = (template_dir / "docs" / "freebsd" / "content.md")
                    project_context[project]["details"]["usage_file"] = usage_file
                    project_context[project]["details"]["usage_file_available"] = (template_dir / "docs" / "freebsd" / "content.md").exists()
                    compose_file = (template_dir / "docs" / "freebsd" / "compose.yaml")
                    project_context[project]["details"]["compose_file"] = compose_file
                    project_context[project]["details"]["compose_file_available"] = (template_dir / "docs" / "freebsd" / "content.md").exists()
                    project_context[project]["details"]["license_file_available"] = (template_dir / "LICENSE").exists()

                for project_version in p_details["versions"]:
                    # print(project_version)
                    pv_parts = project_version.split(".")
                    project_major_version = pv_parts[0]
                    project_minor_version = pv_parts[1] if len(pv_parts) > 1 else "0"
                    project_patch_version = pv_parts[2] if len(pv_parts) > 2 else "0"
                    project_port_revision = pv_parts[3] if len(pv_parts) > 3 else "0"
                    project_major_minor_version = f"{project_major_version}.{project_minor_version}" if len(pv_parts) > 1 else project_major_version
                    project_major_minor_patch_version = f"{project_major_minor_version}.{project_patch_version}" if len(pv_parts) > 2 else project_major_minor_version
                    project_version_dir = project_major_minor_version
                    image_dir = build_images_dir / f"{os_major_version}.{short_os_minor_version}" / project / project_version_dir
                    image_dir.parent.mkdir(parents=True,exist_ok=True)
                    # print(f"{image_dir}")
                    if p_details["type"] == 'os_variant':
                        base_image_digest = ovmj_details[os_minor_and_patch_version][project_version]["index"]
                    else:
                        tag_last_pushed = None
                        base_image_digest = None
                    if p_details["type"] == 'os_variant' \
                        and os_name == "freebsd" \
                        and project_version in ["static", "dynamic"]:
                        build_image = False
                    elif project in ["python", "uv"] and project_version != "3.11":
                        # disabled until we deploy a poudriere + pkg server supporting 3.10 and 3.12 to 3.14 flavours
                        build_image = False
                    else:
                        build_image = True

                    # ALL
                    full_image_tag = f"{project_alias}:{project_major_minor_patch_version}-{tag_os_name}{os_major_minor_version}"
                    image_tags = set([
                        full_image_tag,
                        f"{project_alias}:{project_major_minor_version}-{tag_os_name}{os_major_minor_version}",
                    ])
                    # A
                    if project_major_minor_version == reference_project_version:
                        image_tags.update(set([
                            f"{project_alias}:{project_major_version}-{tag_os_name}{os_major_minor_version}",
                            f"{project_alias}:{tag_os_name}{os_major_minor_version}",
                        ]))
                    # B
                    if os_minor_version == os_reference_versions[os_major_version]:
                        image_tags.update(set([
                            f"{project_alias}:{project_major_minor_patch_version}-{tag_os_name}{os_major_version}",
                            f"{project_alias}:{project_major_minor_version}-{tag_os_name}{os_major_version}",
                        ]))
                        # C = A & B
                        if project_major_minor_version == reference_project_version:
                            image_tags.update(set([
                                f"{project_alias}:{project_major_version}-{tag_os_name}{os_major_version}",
                                f"{project_alias}:{tag_os_name}{os_major_version}",
                            ]))
                    # D
                    if os_major_minor_version == f"{reference_os_major_minor_version}":
                        image_tags.update(set([
                            f"{project_alias}:{project_major_minor_patch_version}-{tag_os_name}".strip("-"),
                            f"{project_alias}:{project_major_minor_version}-{tag_os_name}".strip("-"),
                        ]))
                        # E = A & D
                        if project_major_minor_version == reference_project_version:
                            image_tags.update(set([
                                f"{project_alias}:{project_major_version}-{tag_os_name}".strip("-"),
                                f"{project_alias}:{tag_os_name}".strip(":"),
                            ]))
                            project_context[project]['details']["project_major_minor_patch_version"] = project_major_minor_patch_version
                            project_context[project]['details']["reference_full_image_tag"] = full_image_tag
                            project_context[project]['details']["reference_min_image_tag"] = f"{project_alias}:{project_major_version}-{tag_os_name}".strip("-")
                    image_tags = sorted(image_tags)
                    supported_tags = []
                    for tag in image_tags:
                        try:
                            supported_tags.append(tag.split(":")[1])
                        except IndexError:
                            supported_tags.append("latest")

                    tag_last_pushed = image_digests[os_major_version][os_minor_and_patch_version]["tag_last_pushed"]
                    context = {
                        "os_major_version": os_major_version,
                        "os_minor_and_patch_version": os_minor_and_patch_version,
                        "os_minor_version": os_minor_version,
                        "os_patch_version": os_patch_version,
                        "short_os_minor_version": short_os_minor_version,
                        "os_minor_version_digit": os_minor_version_digit,
                        "os_security_patch": os_security_patch,
                        "project_version": project_version,
                        "project": project,
                        "project_alias": project_alias,
                        "project_major_version": project_major_version,
                        "project_minor_version": project_minor_version,
                        "project_major_minor_version": project_major_minor_version,
                        "project_major_minor_patch_version": project_major_minor_patch_version,
                        "project_patch_version": project_patch_version,
                        "project_port_revision": project_port_revision,
                        "image_tags": image_tags,
                        "supported_tags": supported_tags,
                        "reference_project_version": reference_project_version,
                        "registry": registry,
                        "push_registries": push_registries,
                        "tag_last_pushed": dt.datetime.fromisoformat(tag_last_pushed).strftime("%Y%m%d%H%M%S%z"),
                        "full_image_tag": full_image_tag,
                        "base_image_digest": base_image_digest,
                        "build_image": build_image,
                        "build_environment": build_environment,
                        "extra": p_details["context"],
                    }
                    project_context[project]["images"][full_image_tag] = context
                    shutil.copytree(template_dir, image_dir, ignore=shutil.ignore_patterns('*.j2', 'ci_cd', 'docs'))

                    # Render scripts
                    if build_image:
                        (image_dir / "ci_cd").mkdir(parents=True,exist_ok=True)
                        by_os_version_dir = build_scripts_dir / "by_os_version" / f"{os_name}{os_major_minor_version}"
                        by_os_version_dir.mkdir(parents=True,exist_ok=True)
                        by_project_dir = build_scripts_dir / "by_project" / project_alias
                        by_project_dir.mkdir(parents=True,exist_ok=True)
                        for script_id in ["build", "test", "push", "run_pipeline"]:
                            default_script_template = j2_env.get_template(f"ci_cd/{script_id}.sh.j2")
                            script_file = image_dir / "ci_cd" / f"{script_id}.sh"
                            if project in templates_list and \
                                f"{project}/ci_cd/{script_id}.sh.j2" in templates_list[project]:
                                script_template = j2_env.get_template(f"{project}/ci_cd/{script_id}.sh.j2")
                            else:
                                script_template = default_script_template
                            script_file.write_text(script_template.render(context))
                            script_file.chmod(0o755)

                            target_scripts = [
                                by_os_version_dir / f"{script_id}.sh",
                                by_project_dir / f"{script_id}.sh",
                            ]
                            line = "/".join(script_file.absolute().parts[base_dir_part_count:])
                            for target_script in target_scripts:
                                if not target_script.exists():
                                    target_script.write_text("""#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

""")
                                    target_script.chmod(0o755)
                                with target_script.open("a") as _file:
                                    _file.write(line + "\n")

                    # Render project templates
                    if project in templates_list:
                        for file_stub, _file in templates_list[project].items():
                            if  _file.parent.parent != pathlib.Path("."):
                                continue
                            (image_dir / _file.stem).write_text(
                                j2_env.get_template(file_stub).render(context)
                            )

    # Render docs
    (build_dir / "mkdocs.yml").write_text(
        j2_env.get_template("oci_containers_mkdocs/mkdocs.yml.j2").render({"projects": project_context})
    )
    for project, context in project_context.items():
        project_docs_dir = build_docs_dir / "images" / project
        shutil.copytree(
            base_dir / "templates" / project / "docs" / "freebsd",
            project_docs_dir,
            ignore=shutil.ignore_patterns('*.j2')
        )
        (project_docs_dir / "index.md").write_text(
            j2_env.get_template("oci_containers_mkdocs/project_page.md.j2").render(context)
        )
        for file_stub, _file in templates_list[project].items():
            if  _file.parent.parent == pathlib.Path(".") or _file.parent.stem == "ci_cd":
                continue
            rendered_file = project_docs_dir / "/".join(_file.parts[3:-1]) / _file.stem
            rendered_file.parent.mkdir(parents=True,exist_ok=True)
            rendered_file.write_text(
                j2_env.get_template(file_stub).render(context)
            )

if __name__ == "__main__":
    main()
