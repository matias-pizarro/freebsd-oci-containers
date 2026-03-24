"""Tests for the CI/CD generator module."""

from __future__ import annotations

from freebsd_containers.cicd import (
    render_cicd_scripts,
    resolve_cicd_source_paths,
)
from freebsd_containers.templates import create_j2_env, group_templates_by_project


class TestResolveCicdSourcePaths:
    """Verify CI/CD script source path resolution."""

    def test_project_specific_script_takes_precedence(self, project_root):
        # base has its own ci_cd/test.sh.j2
        paths = resolve_cicd_source_paths(project_root, "base")
        assert "test" in paths
        assert "base" in paths["test"]

    def test_fallback_to_shared_script(self, project_root):
        # base does not have its own ci_cd/build.sh.j2 — should fallback
        paths = resolve_cicd_source_paths(project_root, "base")
        assert "build" in paths
        assert paths["build"].startswith("ci_cd/")

    def test_all_script_ids_present(self, project_root):
        paths = resolve_cicd_source_paths(project_root, "base")
        for script_id in ("build", "test", "push"):
            assert script_id in paths


class TestRenderCicdScripts:
    """Verify CI/CD script rendering."""

    def test_renders_scripts_to_output_dir(self, project_root, tmp_path):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)

        context = {
            "os_major_version": "14",
            "os_minor_version": "3",
            "os_patch_version": "",
            "os_minor_and_patch_version": "3",
            "short_os_minor_version": "3",
            "os_minor_version_digit": "3",
            "os_security_patch": "p5",
            "project_version": "runtime",
            "project": "base",
            "project_alias": "freebsd-base",
            "project_major_version": "runtime",
            "project_minor_version": "0",
            "project_major_minor_version": "runtime",
            "project_major_minor_patch_version": "runtime",
            "project_patch_version": "0",
            "project_port_revision": "0",
            "image_tags": ["freebsd-base:runtime-14.3"],
            "supported_tags": ["runtime-14.3"],
            "reference_project_version": "runtime",
            "registry": {"name": None, "username": None, "project": None},
            "push_registries": {},
            "tag_last_pushed": "20250101000000+0000",
            "full_image_tag": "freebsd-base:runtime-14.3",
            "base_image_digest": "sha256:abc",
            "build_image": True,
            "build_environment": {"pool_name": "zroot"},
            "extra": {},
        }

        image_dir = tmp_path / "image"
        image_dir.mkdir()
        scripts_dir = tmp_path / "ci_cd"
        scripts_dir.mkdir()
        base_dir_part_count = len(project_root.parts)

        render_cicd_scripts(
            env=env,
            grouped=grouped,
            project="base",
            context=context,
            image_dir=image_dir,
            scripts_dir=scripts_dir,
            os_name="freebsd",
            os_major_minor_version="14.3",
            project_alias="freebsd-base",
            base_dir_part_count=base_dir_part_count,
        )

        # CI/CD scripts should exist in the image dir
        cicd_dir = image_dir / "ci_cd"
        assert cicd_dir.exists()
        for script in ("build.sh", "test.sh", "push.sh", "run_pipeline.sh"):
            assert (cicd_dir / script).exists()

    def test_aggregation_scripts_created(self, project_root, tmp_path):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)

        context = {
            "os_major_version": "14",
            "os_minor_version": "3",
            "os_patch_version": "",
            "os_minor_and_patch_version": "3",
            "short_os_minor_version": "3",
            "os_minor_version_digit": "3",
            "os_security_patch": "p5",
            "project_version": "runtime",
            "project": "base",
            "project_alias": "freebsd-base",
            "project_major_version": "runtime",
            "project_minor_version": "0",
            "project_major_minor_version": "runtime",
            "project_major_minor_patch_version": "runtime",
            "project_patch_version": "0",
            "project_port_revision": "0",
            "image_tags": ["freebsd-base:runtime-14.3"],
            "supported_tags": ["runtime-14.3"],
            "reference_project_version": "runtime",
            "registry": {"name": None, "username": None, "project": None},
            "push_registries": {},
            "tag_last_pushed": "20250101000000+0000",
            "full_image_tag": "freebsd-base:runtime-14.3",
            "base_image_digest": "sha256:abc",
            "build_image": True,
            "build_environment": {"pool_name": "zroot"},
            "extra": {},
        }

        image_dir = tmp_path / "image"
        image_dir.mkdir()
        scripts_dir = tmp_path / "ci_cd"
        scripts_dir.mkdir()
        base_dir_part_count = len(project_root.parts)

        render_cicd_scripts(
            env=env,
            grouped=grouped,
            project="base",
            context=context,
            image_dir=image_dir,
            scripts_dir=scripts_dir,
            os_name="freebsd",
            os_major_minor_version="14.3",
            project_alias="freebsd-base",
            base_dir_part_count=base_dir_part_count,
        )

        # Aggregation directories should exist
        by_os = scripts_dir / "by_os_version" / "freebsd14.3"
        by_proj = scripts_dir / "by_project" / "freebsd-base"
        assert by_os.exists()
        assert by_proj.exists()
