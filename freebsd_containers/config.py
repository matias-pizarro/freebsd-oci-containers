"""Configuration constants and registry management for freebsd_containers.

This module centralises architecture mappings, compiled regex patterns,
and registry configuration that were previously inline in build.py.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any

# ---------------------------------------------------------------------------
# Architecture mapping
# ---------------------------------------------------------------------------

ARCH_MAP: dict[str, str] = {
    "amd64": "amd64",
    "arm64": "aarch64",
}

# ---------------------------------------------------------------------------
# Compiled regex patterns used in upstream docs translation
# ---------------------------------------------------------------------------

DOLLAR_PROMPT_PATTERN: re.Pattern[str] = re.compile(r"\$ ")
"""Matches shell prompts like ``$ `` in upstream documentation."""

DOCKER_PATTERN: re.Pattern[str] = re.compile(r"\bdocker\b")
"""Matches the word *docker* as a whole word."""

COMPOSE_PATTERN: re.Pattern[str] = re.compile(r"#* *%%COMPOSE%%")
"""Matches compose placeholder, optionally preceded by comment markers."""

IMAGE_PATTERN: re.Pattern[str] = re.compile(r"%%IMAGE%%")
"""Matches the image-name placeholder in upstream docs."""

LOGO_PATTERN: re.Pattern[str] = re.compile(r"%%LOGO%%")
"""Matches the logo placeholder in upstream docs."""

HASH_PATTERN: re.Pattern[str] = re.compile(r"(\#+ )")
"""Captures Markdown heading prefixes (e.g. ``## ``)."""

HASH_REPLACEMENT: str = "#\\1"
"""Replacement string that adds one heading level."""


# ---------------------------------------------------------------------------
# Registry configuration
# ---------------------------------------------------------------------------


@dataclass
class RegistryConfig:
    """Typed representation of a container registry entry.

    Attributes:
        name: Registry hostname (e.g. ``ghcr.io``).  ``None`` for local.
        username: Registry username / namespace.
        project: Repository name within the namespace.
        slug: Short identifier used in file paths.
        icon: Material icon identifier for docs.
    """

    name: str | None = None
    username: str | None = None
    project: str | None = None
    slug: str | None = None
    icon: str | None = None

    @classmethod
    def from_dict(cls, data: dict[str, Any]) -> RegistryConfig:
        """Create a :class:`RegistryConfig` from a raw dict (versions.json)."""
        return cls(
            name=data.get("name"),
            username=data.get("username"),
            project=data.get("project"),
            slug=data.get("slug"),
            icon=data.get("icon"),
        )

    @property
    def prefix(self) -> str:
        """Return the full image-name prefix including trailing slash.

        For ``ghcr.io/user/proj`` the prefix is ``ghcr.io/user/proj/``.
        For a local registry with all-None fields the prefix is ``""``.
        """
        parts = [p for p in (self.name, self.username, self.project) if p]
        if not parts:
            return ""
        return "/".join(parts) + "/"


def get_registry(
    registry_id: str,
    registries: dict[str, dict[str, Any]],
) -> RegistryConfig:
    """Load a :class:`RegistryConfig` by *registry_id* from raw registry data.

    Args:
        registry_id: Key into the ``registries`` mapping (e.g. ``"github"``).
        registries: The ``registries`` section of ``versions.json``.

    Returns:
        A typed :class:`RegistryConfig` instance.

    Raises:
        KeyError: If *registry_id* is not found.
    """
    return RegistryConfig.from_dict(registries[registry_id])
