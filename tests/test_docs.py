"""Tests for the docs generator module."""

from __future__ import annotations

from pathlib import Path

from freebsd_containers.docs import render_docs, render_mkdocs_yml
from freebsd_containers.templates import create_j2_env, group_templates_by_project


def _make_project_context(project_root: Path) -> dict:
    """Build a minimal project context that satisfies the templates."""
    template_dir = project_root / "templates" / "base"
    return {
        "project_alias": "freebsd-base",
        "details": {
            "name": "Base",
            "slug": "base",
            "icon": "simple/freebsd",
            "type": "os_variant",
            "versions": ["static", "dynamic", "runtime"],
            "context": {},
            "reference_project_version": "runtime",
            "usage_file": template_dir / "docs" / "freebsd" / "content.md",
            "usage_file_available": False,
            "compose_file": template_dir / "docs" / "freebsd" / "compose.yaml",
            "compose_file_available": False,
            "license_file_available": False,
        },
        "images": {},
        "reference_os_major_minor_version": "14.3",
        "reference_path": "images/14.3/base/runtime",
        "template_path": "templates/base",
        "ci_cd_source_paths": {
            "build": "ci_cd/build.sh.j2",
            "test": "base/ci_cd/test.sh.j2",
            "push": "ci_cd/push.sh.j2",
        },
    }


class TestRenderMkdocsYml:
    """Verify mkdocs.yml rendering."""

    def test_renders_yml_file(self, project_root, tmp_path):
        env = create_j2_env(project_root)
        project_context = {
            "base": {
                "project_alias": "freebsd-base",
                "details": {"name": "Base"},
                "images": {},
            },
        }
        output = tmp_path / "mkdocs.yml"
        render_mkdocs_yml(env, project_context, output)
        assert output.exists()
        content = output.read_text()
        assert len(content) > 0


class TestRenderDocs:
    """Verify per-project docs rendering."""

    def test_creates_project_docs_dir(self, project_root, tmp_path):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)
        context = _make_project_context(project_root)
        docs_dir = tmp_path / "docs"
        docs_dir.mkdir()
        render_docs(
            env=env,
            grouped=grouped,
            project="base",
            context=context,
            base_dir=project_root,
            docs_dir=docs_dir,
        )
        project_docs = docs_dir / "images" / "base"
        assert project_docs.exists()

    def test_creates_index_page(self, project_root, tmp_path):
        env = create_j2_env(project_root)
        raw = env.list_templates(extensions="j2")
        grouped = group_templates_by_project(raw)
        context = _make_project_context(project_root)
        docs_dir = tmp_path / "docs"
        docs_dir.mkdir()
        render_docs(
            env=env,
            grouped=grouped,
            project="base",
            context=context,
            base_dir=project_root,
            docs_dir=docs_dir,
        )
        assert (docs_dir / "images" / "base" / "index.md").exists()
