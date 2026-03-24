"""Tests for the tags module — the tag algebra.

Tests use known-good tag outputs derived from the build.py tag generation
logic. The tag sets are:

- ALL: Every combination gets full + major.minor tags
- A: Reference project version gets major + bare OS tags
- B: Reference OS minor version gets major-OS tags
- C: A & B intersection
- D: Reference OS major.minor gets OS-free tags
- E: A & D intersection (the "latest" equivalent)
"""

from __future__ import annotations

from freebsd_containers.tags import TagInput, generate_tags


def _make_input(
    *,
    project_alias: str = "postgres",
    tag_os_name: str = "freebsd",
    project_major: str = "18",
    project_minor: str = "0",
    project_patch: str = "0",
    project_major_minor: str = "18",
    project_major_minor_patch: str = "18",
    os_major: str = "14",
    os_minor: str = "3",
    os_major_minor: str = "14.3",
    reference_project_version: str = "18",
    os_ref_minor_for_major: str = "3",
    reference_os_major_minor: str = "14.3",
) -> TagInput:
    return TagInput(
        project_alias=project_alias,
        tag_os_name=tag_os_name,
        project_major=project_major,
        project_minor=project_minor,
        project_patch=project_patch,
        project_major_minor=project_major_minor,
        project_major_minor_patch=project_major_minor_patch,
        os_major=os_major,
        os_minor=os_minor,
        os_major_minor=os_major_minor,
        reference_project_version=reference_project_version,
        os_ref_minor_for_major=os_ref_minor_for_major,
        reference_os_major_minor=reference_os_major_minor,
    )


class TestAllTags:
    """ALL tags: every combination gets full + major.minor tags."""

    def test_full_image_tag_present(self):
        inp = _make_input()
        result = generate_tags(inp)
        assert "postgres:18-freebsd14.3" in result.image_tags

    def test_major_minor_tag_present(self):
        inp = _make_input()
        result = generate_tags(inp)
        assert "postgres:18-freebsd14.3" in result.image_tags

    def test_full_image_tag_field(self):
        inp = _make_input()
        result = generate_tags(inp)
        assert result.full_image_tag == "postgres:18-freebsd14.3"


class TestATags:
    """A tags: reference project version gets major + bare OS tags."""

    def test_reference_project_gets_major_os_tag(self):
        inp = _make_input(
            project_major_minor="18",
            reference_project_version="18",
        )
        result = generate_tags(inp)
        assert "postgres:18-freebsd14.3" in result.image_tags
        assert "postgres:freebsd14.3" in result.image_tags

    def test_non_reference_project_lacks_bare_os_tag(self):
        inp = _make_input(
            project_major_minor="17",
            project_major="17",
            project_major_minor_patch="17",
            reference_project_version="18",
        )
        result = generate_tags(inp)
        assert "postgres:freebsd14.3" not in result.image_tags


class TestBTags:
    """B tags: reference OS minor version gets major-OS tags."""

    def test_reference_os_minor_gets_osmajor_tags(self):
        inp = _make_input(
            os_minor="3",
            os_ref_minor_for_major="3",
        )
        result = generate_tags(inp)
        assert "postgres:18-freebsd14" in result.image_tags

    def test_non_reference_os_minor_lacks_osmajor_tags(self):
        inp = _make_input(
            os_minor="2",
            os_major_minor="14.2",
            os_ref_minor_for_major="3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        assert "postgres:18-freebsd14" not in result.image_tags


class TestCTags:
    """C tags: A & B intersection — reference project + reference OS minor."""

    def test_both_reference_gets_bare_osmajor(self):
        inp = _make_input(
            project_major_minor="18",
            reference_project_version="18",
            os_minor="3",
            os_ref_minor_for_major="3",
        )
        result = generate_tags(inp)
        assert "postgres:freebsd14" in result.image_tags

    def test_non_reference_project_lacks_bare_osmajor(self):
        inp = _make_input(
            project_major_minor="17",
            project_major="17",
            project_major_minor_patch="17",
            reference_project_version="18",
            os_minor="3",
            os_ref_minor_for_major="3",
        )
        result = generate_tags(inp)
        assert "postgres:freebsd14" not in result.image_tags


class TestDTags:
    """D tags: reference OS major.minor gets version-without-OS-version tags.

    For upstream projects (tag_os_name="freebsd"), D tags produce tags
    like ``postgres:18-freebsd`` (OS name but no OS version).
    For os_variant projects (tag_os_name=""), they produce truly OS-free
    tags like ``freebsd-base:runtime``.
    """

    def test_reference_os_gets_d_tag_upstream(self):
        inp = _make_input(
            os_major_minor="14.3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        # D tag: project version + OS name, no OS version
        assert "postgres:18-freebsd" in result.image_tags

    def test_non_reference_os_lacks_d_tag(self):
        inp = _make_input(
            os_major_minor="15.0",
            os_major="15",
            os_minor="0",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        assert "postgres:18-freebsd" not in result.image_tags


class TestETags:
    """E tags: A & D intersection — the 'latest' equivalent.

    For upstream projects: ``postgres:freebsd`` (bare alias + OS name).
    For os_variant projects: ``freebsd-base`` (bare alias).
    """

    def test_full_reference_gets_e_tag_upstream(self):
        inp = _make_input(
            project_major_minor="18",
            reference_project_version="18",
            os_major_minor="14.3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        # E tag for upstream: "postgres:freebsd" (strip trailing colon)
        assert "postgres:freebsd" in result.image_tags

    def test_non_full_reference_no_e_tag(self):
        inp = _make_input(
            project_major_minor="17",
            project_major="17",
            project_major_minor_patch="17",
            reference_project_version="18",
            os_major_minor="14.3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        assert "postgres:freebsd" not in result.image_tags


class TestOsVariantTags:
    """OS variant projects (type=os_variant) have empty tag_os_name."""

    def test_os_variant_full_tag(self):
        inp = _make_input(
            project_alias="freebsd-base",
            tag_os_name="",
            project_major="runtime",
            project_minor="0",
            project_patch="0",
            project_major_minor="runtime",
            project_major_minor_patch="runtime",
            reference_project_version="runtime",
            os_major_minor="14.3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        assert result.full_image_tag == "freebsd-base:runtime-14.3"

    def test_os_variant_d_tag_strips_trailing_dash(self):
        """D tags with empty tag_os_name should strip the trailing dash."""
        inp = _make_input(
            project_alias="freebsd-base",
            tag_os_name="",
            project_major="runtime",
            project_minor="0",
            project_patch="0",
            project_major_minor="runtime",
            project_major_minor_patch="runtime",
            reference_project_version="runtime",
            os_major_minor="14.3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        # Should have "freebsd-base:runtime" not "freebsd-base:runtime-"
        assert "freebsd-base:runtime" in result.image_tags
        tags_with_trailing_dash = [t for t in result.image_tags if t.endswith("-")]
        assert not tags_with_trailing_dash

    def test_os_variant_e_tag_bare(self):
        """E tags for os_variant: bare project name without trailing colon."""
        inp = _make_input(
            project_alias="freebsd-base",
            tag_os_name="",
            project_major="runtime",
            project_minor="0",
            project_patch="0",
            project_major_minor="runtime",
            project_major_minor_patch="runtime",
            reference_project_version="runtime",
            os_major_minor="14.3",
            os_minor="3",
            os_ref_minor_for_major="3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        assert "freebsd-base" in result.image_tags


class TestSupportedTags:
    """Verify the supported_tags list (tag parts after the colon)."""

    def test_supported_tags_are_tag_suffixes(self):
        inp = _make_input()
        result = generate_tags(inp)
        for tag in result.supported_tags:
            assert ":" not in tag

    def test_bare_tag_becomes_latest_for_os_variant(self):
        """Only os_variant bare tags (no colon) become 'latest'."""
        inp = _make_input(
            project_alias="freebsd-base",
            tag_os_name="",
            project_major="runtime",
            project_minor="0",
            project_patch="0",
            project_major_minor="runtime",
            project_major_minor_patch="runtime",
            reference_project_version="runtime",
            os_major_minor="14.3",
            os_minor="3",
            os_ref_minor_for_major="3",
            reference_os_major_minor="14.3",
        )
        result = generate_tags(inp)
        assert "latest" in result.supported_tags


class TestTagsSorted:
    """Tags must be returned sorted."""

    def test_image_tags_are_sorted(self):
        inp = _make_input()
        result = generate_tags(inp)
        assert result.image_tags == sorted(result.image_tags)
