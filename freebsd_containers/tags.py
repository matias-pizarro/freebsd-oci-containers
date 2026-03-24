"""Tag algebra for FreeBSD OCI container images.

Generates the full set of OCI image tags for each (project, version, OS)
combination according to the following tag sets:

- **ALL**: Every combination gets ``full`` + ``major.minor`` tags.
- **A**: Reference project version adds ``major`` + bare-OS tags.
- **B**: Reference OS minor version adds ``major-OS`` tags.
- **C**: A ∩ B — both references, adds ``bare-OSmajor`` tags.
- **D**: Reference OS major.minor adds OS-free tags.
- **E**: A ∩ D — the "latest" equivalent.
"""

from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class TagInput:
    """Inputs required to compute image tags for one build combination.

    Attributes:
        project_alias: Image name (e.g. ``"postgres"``, ``"freebsd-base"``).
        tag_os_name: OS name in tags (``"freebsd"`` for upstream, ``""`` for
            os_variant projects).
        project_major: Project major version component.
        project_minor: Project minor version component.
        project_patch: Project patch version component.
        project_major_minor: ``"{major}.{minor}"`` or bare major.
        project_major_minor_patch: Includes patch when available.
        os_major: OS major version.
        os_minor: OS minor version (parsed, not raw key).
        os_major_minor: ``"{os_major}.{os_minor}"``.
        reference_project_version: Project's reference version string.
        os_ref_minor_for_major: Reference OS minor for this OS major.
        reference_os_major_minor: Overall reference OS ``"{major}.{minor}"``.
    """

    project_alias: str
    tag_os_name: str
    project_major: str
    project_minor: str
    project_patch: str
    project_major_minor: str
    project_major_minor_patch: str
    os_major: str
    os_minor: str
    os_major_minor: str
    reference_project_version: str
    os_ref_minor_for_major: str
    reference_os_major_minor: str


@dataclass(frozen=True)
class TagResult:
    """Output of the tag generation.

    Attributes:
        full_image_tag: The most specific tag for this combination.
        image_tags: Sorted list of all generated tags.
        supported_tags: Tag suffixes (after the colon) for documentation.
    """

    full_image_tag: str
    image_tags: list[str]
    supported_tags: list[str]


def generate_tags(inp: TagInput) -> TagResult:
    """Compute the full set of image tags for a single build combination.

    Args:
        inp: All version and reference data needed for tag computation.

    Returns:
        A :class:`TagResult` with sorted tags and supported-tag suffixes.
    """
    alias = inp.project_alias
    osn = inp.tag_os_name

    # ALL — every combination gets full + major.minor tags
    full_image_tag = (
        f"{alias}:{inp.project_major_minor_patch}-{osn}{inp.os_major_minor}"
    )
    tags: set[str] = {
        full_image_tag,
        f"{alias}:{inp.project_major_minor}-{osn}{inp.os_major_minor}",
    }

    is_ref_project = inp.project_major_minor == inp.reference_project_version
    is_ref_os_minor = inp.os_minor == inp.os_ref_minor_for_major
    is_ref_os_major_minor = inp.os_major_minor == inp.reference_os_major_minor

    # A — reference project version
    if is_ref_project:
        tags.update(
            {
                f"{alias}:{inp.project_major}-{osn}{inp.os_major_minor}",
                f"{alias}:{osn}{inp.os_major_minor}",
            }
        )

    # B — reference OS minor version
    if is_ref_os_minor:
        tags.update(
            {
                f"{alias}:{inp.project_major_minor_patch}-{osn}{inp.os_major}",
                f"{alias}:{inp.project_major_minor}-{osn}{inp.os_major}",
            }
        )
        # C: A ∩ B
        if is_ref_project:
            tags.update(
                {
                    f"{alias}:{inp.project_major}-{osn}{inp.os_major}",
                    f"{alias}:{osn}{inp.os_major}",
                }
            )

    # D — reference OS major.minor (overall)
    if is_ref_os_major_minor:
        tags.update(
            {
                f"{alias}:{inp.project_major_minor_patch}-{osn}".strip("-"),
                f"{alias}:{inp.project_major_minor}-{osn}".strip("-"),
            }
        )
        # E: A ∩ D
        if is_ref_project:
            tags.update(
                {
                    f"{alias}:{inp.project_major}-{osn}".strip("-"),
                    f"{alias}:{osn}".strip(":"),
                }
            )

    sorted_tags = sorted(tags)

    # Supported tags are the suffixes after the colon
    supported: list[str] = []
    for tag in sorted_tags:
        if ":" in tag:
            supported.append(tag.split(":")[1])
        else:
            supported.append("latest")

    return TagResult(
        full_image_tag=full_image_tag,
        image_tags=sorted_tags,
        supported_tags=supported,
    )
