"""Version matrix loading and parsing for freebsd_containers.

This module handles loading ``versions.json`` and parsing OS and project
version strings into typed, structured representations.
"""

from __future__ import annotations

import json
from dataclasses import dataclass
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from pathlib import Path


@dataclass(frozen=True)
class OsVersion:
    """Parsed representation of an OS version pair (major + minor key).

    Attributes:
        major: OS major version (e.g. ``"14"``).
        minor: Minor version component (e.g. ``"3"``, ``"snapshot"``).
        patch: Patch component if present (e.g. ``"beta5"``), else ``""``.
        minor_and_patch: Original minor key (e.g. ``"0.beta5"`` or ``"3"``).
        short_minor: Abbreviated form (``"snap"`` for snapshot, else minor).
        minor_digit: Numeric form (``"0"`` for snapshot, else minor).
        major_minor: ``"{major}.{minor}"`` string.
    """

    major: str
    minor: str
    patch: str
    minor_and_patch: str
    short_minor: str
    minor_digit: str
    major_minor: str


@dataclass(frozen=True)
class ProjectVersion:
    """Parsed representation of a project version string.

    Attributes:
        raw: The original version string (e.g. ``"1.20.14.5"``).
        major: First component.
        minor: Second component (``"0"`` if absent).
        patch: Third component (``"0"`` if absent).
        port_revision: Fourth component (``"0"`` if absent).
        major_minor: ``"{major}.{minor}"`` or just major if single-part.
        major_minor_patch: Includes patch if 3+ parts.
        version_dir: Directory name for build output.
    """

    raw: str
    major: str
    minor: str
    patch: str
    port_revision: str
    major_minor: str
    major_minor_patch: str
    version_dir: str


@dataclass
class VersionMatrix:
    """Full version matrix loaded from ``versions.json``.

    This is the central data structure that feeds the build pipeline.
    """

    build_environment: dict[str, Any]
    registries: dict[str, dict[str, Any]]
    projects: dict[str, dict[str, Any]]
    os_versions: dict[str, dict[str, dict[str, Any]]]
    os_reference_versions: dict[str, str]
    os_security_patches: dict[str, str]
    image_digests: dict[str, dict[str, Any]]
    reference_os_major_version: str = ""
    reference_os_major_minor_version: str = ""

    def __post_init__(self) -> None:
        """Derive reference version fields after initialisation."""
        ref_major = self.os_reference_versions.get("reference_os_major_version", "")
        self.reference_os_major_version = ref_major
        ref_minor = self.os_reference_versions.get(ref_major, "")
        self.reference_os_major_minor_version = (
            f"{ref_major}.{ref_minor}" if ref_major else ""
        )


def parse_os_version(major: str, minor_key: str) -> OsVersion:
    """Parse an OS major version and minor-version key into an :class:`OsVersion`.

    Args:
        major: OS major version (e.g. ``"14"``).
        minor_key: Minor version key from versions.json (e.g. ``"3"``,
            ``"0.beta5"``, ``"snapshot"``).

    Returns:
        A frozen :class:`OsVersion` with all derived fields populated.
    """
    parts = minor_key.split(".")
    minor = parts[0]
    patch = parts[1] if len(parts) > 1 else ""
    minor_and_patch = minor if patch == "" else f"{minor}.{patch}"
    short_minor = "snap" if minor == "snapshot" else minor
    minor_digit = "0" if minor == "snapshot" else minor
    major_minor = f"{major}.{minor}"

    return OsVersion(
        major=major,
        minor=minor,
        patch=patch,
        minor_and_patch=minor_and_patch,
        short_minor=short_minor,
        minor_digit=minor_digit,
        major_minor=major_minor,
    )


def parse_project_version(version: str) -> ProjectVersion:
    """Parse a project version string into a :class:`ProjectVersion`.

    Args:
        version: Raw version string (e.g. ``"1.20.14.5"``, ``"runtime"``).

    Returns:
        A frozen :class:`ProjectVersion` with all derived fields populated.
    """
    parts = version.split(".")
    major = parts[0]
    minor = parts[1] if len(parts) > 1 else "0"
    patch = parts[2] if len(parts) > 2 else "0"
    port_revision = parts[3] if len(parts) > 3 else "0"

    major_minor = f"{major}.{minor}" if len(parts) > 1 else major
    major_minor_patch = f"{major_minor}.{patch}" if len(parts) > 2 else major_minor
    version_dir = major_minor

    return ProjectVersion(
        raw=version,
        major=major,
        minor=minor,
        patch=patch,
        port_revision=port_revision,
        major_minor=major_minor,
        major_minor_patch=major_minor_patch,
        version_dir=version_dir,
    )


def load_versions(versions_file: Path) -> VersionMatrix:
    """Load and parse ``versions.json`` into a :class:`VersionMatrix`.

    Args:
        versions_file: Path to the ``versions.json`` file.

    Returns:
        A populated :class:`VersionMatrix`.

    Raises:
        FileNotFoundError: If the file does not exist.
        json.JSONDecodeError: If the file is not valid JSON.
    """
    with versions_file.open() as f:
        data = json.load(f)

    return VersionMatrix(
        build_environment=data.get("build_environment", {}),
        registries=data.get("registries", {}),
        projects=data.get("projects", {}),
        os_versions=data.get("os_versions", {}),
        os_reference_versions=data.get("os_reference_versions", {}),
        os_security_patches=data.get("os_security_patches", {}),
        image_digests=data.get("image_digests", {}),
    )
