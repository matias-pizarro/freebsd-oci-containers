"""Tests for the templates module."""

from __future__ import annotations

from pathlib import Path

import jinja2

from freebsd_containers.templates import (
    create_j2_env,
    group_templates_by_project,
    render_project_templates,
    translate_upstream_docs,
)


class TestCreateJ2Env:
    """Verify Jinja2 environment creation."""

    def test_returns_jinja2_environment(self, project_root):
        env = create_j2_env(project_root)
        assert isinstance(env, jinja2.Environment)

    def test_can_list_templates(self, project_root):
        env = create_j2_env(project_root)
        templates = env.list_templates(extensions="j2")
        assert len(templates) > 0

    def test_templates_include_base(self, project_root):
        env = create_j2_env(project_root)
        templates = env.list_templates(extensions="j2")
        assert any("base" in t for t in templates)


class TestGroupTemplatesByProject:
    """Verify template grouping logic."""

    def test_groups_by_project_name(self, project_root):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)
        assert "base" in grouped
        assert "golang" in grouped

    def test_ci_cd_templates_grouped_separately(self, project_root):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)
        assert "ci_cd" in grouped

    def test_values_are_path_dicts(self, project_root):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)
        for templates in grouped.values():
            for stub, path in templates.items():
                assert isinstance(stub, str)
                assert isinstance(path, Path)


class TestTranslateUpstreamDocs:
    """Verify upstream docs translation."""

    def test_replaces_docker_with_podman(self):
        content = "Run docker build to create"
        result = translate_upstream_docs(
            content, project_alias="postgres", compose_content=""
        )
        assert "podman" in result
        assert "docker" not in result

    def test_replaces_image_placeholder(self):
        content = "Pull %%IMAGE%% from registry"
        result = translate_upstream_docs(
            content, project_alias="postgres", compose_content=""
        )
        assert "postgres" in result
        assert "%%IMAGE%%" not in result

    def test_replaces_logo_placeholder(self):
        content = "%%LOGO%%"
        result = translate_upstream_docs(
            content, project_alias="postgres", compose_content=""
        )
        assert "![Project logo]" in result

    def test_replaces_compose_placeholder(self):
        content = "## %%COMPOSE%%"
        compose = "```containerfile\nservices:\n```"
        result = translate_upstream_docs(
            content, project_alias="test", compose_content=compose
        )
        assert "services:" in result

    def test_removes_dollar_prompts(self):
        content = "$ ls -la"
        result = translate_upstream_docs(
            content, project_alias="test", compose_content=""
        )
        assert "$ " not in result

    def test_adds_heading_level(self):
        content = "## Title"
        result = translate_upstream_docs(
            content, project_alias="test", compose_content=""
        )
        assert result == "### Title"


class TestRenderProjectTemplates:
    """Verify project template rendering."""

    def test_renders_containerfile(self, project_root, tmp_path):
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
        output_dir = tmp_path / "output"
        output_dir.mkdir()
        render_project_templates(env, grouped, "base", context, output_dir)
        # Should have rendered the Containerfile
        assert (output_dir / "Containerfile").exists()
