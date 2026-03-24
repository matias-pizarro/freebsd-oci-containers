"""Documentation generation for the FreeBSD OCI containers MkDocs site.

Handles MkDocs scaffolding, ``mkdocs.yml`` rendering, per-project page
generation, and docs template rendering.
"""

from __future__ import annotations

import shutil
from pathlib import Path
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    import jinja2


def render_mkdocs_yml(
    env: jinja2.Environment,
    project_context: dict[str, Any],
    output_path: Path,
) -> None:
    """Render the MkDocs configuration file.

    Args:
        env: Jinja2 environment.
        project_context: Mapping of project name to project context.
        output_path: Path to write ``mkdocs.yml``.
    """
    template = env.get_template("oci_containers_mkdocs/mkdocs.yml.j2")
    output_path.write_text(template.render({"projects": project_context}))


def scaffold_docs(
    base_dir: Path,
    docs_dir: Path,
) -> None:
    """Copy the MkDocs docs scaffolding (non-template static files).

    Args:
        base_dir: Project root directory.
        docs_dir: Target docs build directory.
    """
    template_docs = base_dir / "templates" / "oci_containers_mkdocs" / "docs"
    docs_dir.parent.mkdir(parents=True, exist_ok=True)
    shutil.copytree(
        template_docs,
        docs_dir,
        ignore=shutil.ignore_patterns("*.j2"),
    )


def render_docs(
    *,
    env: jinja2.Environment,
    grouped: dict[str, dict[str, Path]],
    project: str,
    context: dict[str, Any],
    base_dir: Path,
    docs_dir: Path,
) -> None:
    """Render documentation pages for a single project.

    Copies FreeBSD docs from the template tree, renders the project index
    page, and renders any docs-specific Jinja2 templates.

    Args:
        env: Jinja2 environment.
        grouped: Templates grouped by project.
        project: Project name.
        context: Project context dict.
        base_dir: Project root directory.
        docs_dir: Top-level docs build directory.
    """
    project_docs_dir = docs_dir / "images" / project

    # Copy static FreeBSD docs
    freebsd_docs = base_dir / "templates" / project / "docs" / "freebsd"
    if freebsd_docs.exists():
        shutil.copytree(
            freebsd_docs,
            project_docs_dir,
            ignore=shutil.ignore_patterns("*.j2"),
        )
    else:
        project_docs_dir.mkdir(parents=True, exist_ok=True)

    # Render project index page
    index_template = env.get_template("oci_containers_mkdocs/project_page.md.j2")
    (project_docs_dir / "index.md").write_text(index_template.render(context))

    # Render docs-specific templates
    if project not in grouped:
        return

    for stub, path in grouped[project].items():
        # Skip top-level templates and CI/CD templates
        if path.parent.parent == Path() or path.parent.stem == "ci_cd":
            continue
        rendered_file = project_docs_dir / "/".join(path.parts[3:-1]) / path.stem
        rendered_file.parent.mkdir(parents=True, exist_ok=True)
        rendered_file.write_text(env.get_template(stub).render(context))
