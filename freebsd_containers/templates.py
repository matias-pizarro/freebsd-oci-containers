"""Jinja2 template loading, grouping, rendering, and upstream docs translation.

Handles the template pipeline:

1. Create a Jinja2 environment rooted at ``templates/``.
2. Group discovered ``.j2`` files by project name.
3. Render project-specific templates into build output directories.
4. Translate upstream Docker documentation for FreeBSD (replace Docker
   references with Podman, add heading levels, substitute placeholders).
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any

import jinja2

from freebsd_containers.config import (
    COMPOSE_PATTERN,
    DOCKER_PATTERN,
    DOLLAR_PROMPT_PATTERN,
    HASH_PATTERN,
    HASH_REPLACEMENT,
    IMAGE_PATTERN,
    LOGO_PATTERN,
)


def create_j2_env(base_dir: Path) -> jinja2.Environment:
    """Create a Jinja2 environment rooted at ``{base_dir}/templates``.

    Args:
        base_dir: Project root directory containing the ``templates/`` tree.

    Returns:
        A configured :class:`jinja2.Environment`.
    """
    return jinja2.Environment(
        loader=jinja2.FileSystemLoader(base_dir / "templates"),
        autoescape=jinja2.select_autoescape(),
    )


def group_templates_by_project(
    raw_templates: list[str],
) -> dict[str, dict[str, Path]]:
    """Group a flat list of template paths by their project name.

    Templates at the top level (``ci_cd/build.sh.j2``) are grouped under
    their first directory component.  Templates in subdirectories
    (``golang/Containerfile.j2``) are grouped under the project name.

    Args:
        raw_templates: Template paths relative to the ``templates/`` root.

    Returns:
        ``{project: {template_stub: Path}}`` mapping.
    """
    grouped: dict[str, dict[str, Path]] = {}
    for stub in raw_templates:
        path = Path(stub)
        parent_str = str(path.parent)
        project = parent_str if parent_str == "." else path.parts[0]
        if project not in grouped:
            grouped[project] = {}
        grouped[project][stub] = path
    return grouped


def translate_upstream_docs(
    content: str,
    *,
    project_alias: str,
    compose_content: str,
) -> str:
    """Translate upstream Docker documentation for FreeBSD/Podman.

    Applies the following transformations:

    1. Add one heading level (``## `` → ``### ``).
    2. Replace ``%%IMAGE%%`` with the project alias.
    3. Replace ``%%LOGO%%`` with a Markdown image link.
    4. Replace ``%%COMPOSE%%`` with compose file content.
    5. Remove shell prompts (``$ ``).
    6. Replace ``docker`` with ``podman``.

    Args:
        content: Raw upstream Markdown content.
        project_alias: Image name for placeholder substitution.
        compose_content: Rendered compose block (may be empty).

    Returns:
        Translated Markdown string.
    """
    result = re.sub(HASH_PATTERN, HASH_REPLACEMENT, content)
    result = re.sub(IMAGE_PATTERN, project_alias, result)
    result = re.sub(LOGO_PATTERN, "![Project logo](logo.png)", result)
    result = re.sub(COMPOSE_PATTERN, compose_content, result)
    result = re.sub(DOLLAR_PROMPT_PATTERN, "", result)
    return re.sub(DOCKER_PATTERN, "podman", result)


def render_project_templates(
    env: jinja2.Environment,
    grouped: dict[str, dict[str, Path]],
    project: str,
    context: dict[str, Any],
    output_dir: Path,
) -> None:
    """Render project-specific Jinja2 templates into an output directory.

    Only renders templates whose parent's parent is the root (``.``),
    matching the build.py filter at line 384.  CI/CD and docs templates
    are handled by their respective modules.

    Args:
        env: Jinja2 environment.
        grouped: Templates grouped by project.
        project: Project name key.
        context: Template rendering context.
        output_dir: Directory to write rendered files into.
    """
    if project not in grouped:
        return

    for stub, path in grouped[project].items():
        if path.parent.parent != Path():
            continue
        rendered = env.get_template(stub).render(context)
        (output_dir / path.stem).write_text(rendered)
