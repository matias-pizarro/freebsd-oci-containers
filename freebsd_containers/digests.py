"""Docker Hub image digest fetching and parsing.

Fetches base image digests from Docker Hub for FreeBSD ``static``,
``dynamic``, and ``runtime`` images, then merges them into the OS
version matrix.
"""

from __future__ import annotations

import contextlib
import json
from typing import Any

import requests

_IMAGE_VERSIONS = ("static", "dynamic", "runtime")

_HUB_URL_TEMPLATE = (
    "https://hub.docker.com/v2/repositories/freebsd/freebsd-{image_version}"
    "/tags?page=1&page_size=300"
)


def parse_tag_response(
    tags: list[dict[str, Any]],
    arch_map: dict[str, str],
    *,
    image_version: str = "static",
    existing: dict[str, dict[str, Any]] | None = None,
) -> dict[str, dict[str, Any]]:
    """Parse Docker Hub tag API results into a structured digest dict.

    Args:
        tags: List of tag result dicts from the Docker Hub API.
        arch_map: Architecture name mapping (e.g. ``{"arm64": "aarch64"}``).
        image_version: Which image variant these tags are for
            (``"static"``, ``"dynamic"``, or ``"runtime"``).
        existing: Optional existing digest dict to merge into.

    Returns:
        Nested dict ``{os_major: {os_minor: {image_version: {arch: digest}}}}``.
    """
    digests: dict[str, dict[str, Any]] = existing if existing is not None else {}

    for tag in tags:
        os_version: str = tag["name"]
        os_major, short_minor = os_version.split(".", 1)
        os_minor = "snapshot" if short_minor == "snap" else short_minor

        if os_major not in digests:
            digests[os_major] = {}
        if os_minor not in digests[os_major]:
            digests[os_major][os_minor] = {}

        minor_entry = digests[os_major][os_minor]
        if "tag_last_pushed" not in minor_entry:
            minor_entry["tag_last_pushed"] = tag["tag_last_pushed"]

        if image_version not in minor_entry:
            minor_entry[image_version] = {}

        minor_entry[image_version]["index"] = tag["digest"]
        for image in tag["images"]:
            arch = arch_map[image["architecture"]]
            minor_entry[image_version][arch] = image["digest"]

    return digests


def fetch_digests(arch_map: dict[str, str]) -> dict[str, dict[str, Any]]:
    """Fetch image digests for all FreeBSD base image variants from Docker Hub.

    Makes three HTTP requests (one per image version: static, dynamic,
    runtime) and merges the results into a single digest dict.

    Args:
        arch_map: Architecture name mapping.

    Returns:
        Nested digest dict ready for ``versions.json`` ``image_digests`` key.

    Raises:
        Exception: On HTTP errors.
    """
    digests: dict[str, dict[str, Any]] = {}

    for image_version in _IMAGE_VERSIONS:
        url = _HUB_URL_TEMPLATE.format(image_version=image_version)
        response = requests.get(url, timeout=30)
        response.raise_for_status()
        data = response.json()
        digests = parse_tag_response(
            data["results"],
            arch_map,
            image_version=image_version,
            existing=digests,
        )

    return _sort_digests(digests)


def _sort_digests(digests: dict[str, Any]) -> dict[str, Any]:
    """Sort digest dict keys for deterministic JSON output."""
    result: dict[str, Any] = json.loads(json.dumps(digests, sort_keys=True))
    return result


def merge_digests_into_os_versions(
    os_versions: dict[str, dict[str, dict[str, Any]]],
    image_digests: dict[str, dict[str, Any]],
) -> None:
    """Merge fetched image digests into the OS versions matrix in-place.

    For each (os_major, os_minor, image_version) triple in ``os_versions``,
    if a matching entry exists in ``image_digests``, replace the digest
    values.

    Args:
        os_versions: The ``os_versions`` section of ``versions.json``.
        image_digests: The ``image_digests`` section of ``versions.json``.
    """
    for os_major, majors in os_versions.items():
        for os_minor, minors in majors.items():
            for image_version in minors:
                with contextlib.suppress(KeyError):
                    os_versions[os_major][os_minor][image_version] = image_digests[
                        os_major
                    ][os_minor][image_version]
