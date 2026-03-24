"""Tests for the versions module."""

from __future__ import annotations

from freebsd_containers.versions import (
    VersionMatrix,
    load_versions,
    parse_os_version,
    parse_project_version,
)

# ---------------------------------------------------------------------------
# Unit tests for parse helpers
# ---------------------------------------------------------------------------


class TestParseOsVersion:
    """Verify OS version string parsing."""

    def test_simple_minor(self):
        ov = parse_os_version("14", "3")
        assert ov.major == "14"
        assert ov.minor == "3"
        assert ov.patch == ""
        assert ov.minor_and_patch == "3"
        assert ov.short_minor == "3"
        assert ov.minor_digit == "3"
        assert ov.major_minor == "14.3"

    def test_with_patch(self):
        ov = parse_os_version("15", "0.beta5")
        assert ov.major == "15"
        assert ov.minor == "0"
        assert ov.patch == "beta5"
        assert ov.minor_and_patch == "0.beta5"
        assert ov.short_minor == "0"
        assert ov.major_minor == "15.0"

    def test_snapshot(self):
        ov = parse_os_version("16", "snapshot")
        assert ov.minor == "snapshot"
        assert ov.short_minor == "snap"
        assert ov.minor_digit == "0"
        assert ov.major_minor == "16.snapshot"


class TestParseProjectVersion:
    """Verify project version string parsing."""

    def test_single_component(self):
        pv = parse_project_version("runtime")
        assert pv.raw == "runtime"
        assert pv.major == "runtime"
        assert pv.minor == "0"
        assert pv.patch == "0"
        assert pv.port_revision == "0"
        assert pv.major_minor == "runtime"
        assert pv.major_minor_patch == "runtime"
        assert pv.version_dir == "runtime"

    def test_two_components(self):
        pv = parse_project_version("3.11")
        assert pv.major == "3"
        assert pv.minor == "11"
        assert pv.patch == "0"
        assert pv.major_minor == "3.11"
        assert pv.major_minor_patch == "3.11"
        assert pv.version_dir == "3.11"

    def test_three_components(self):
        pv = parse_project_version("1.22.12")
        assert pv.major == "1"
        assert pv.minor == "22"
        assert pv.patch == "12"
        assert pv.major_minor == "1.22"
        assert pv.major_minor_patch == "1.22.12"

    def test_four_components_with_port_revision(self):
        pv = parse_project_version("1.20.14.5")
        assert pv.major == "1"
        assert pv.minor == "20"
        assert pv.patch == "14"
        assert pv.port_revision == "5"
        assert pv.major_minor == "1.20"
        assert pv.major_minor_patch == "1.20.14"


# ---------------------------------------------------------------------------
# Integration tests using real versions.json
# ---------------------------------------------------------------------------


class TestLoadVersions:
    """Verify VersionMatrix loading from real versions.json."""

    def test_load_returns_version_matrix(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert isinstance(vm, VersionMatrix)

    def test_os_versions_populated(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert len(vm.os_versions) >= 1

    def test_projects_populated(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert len(vm.projects) >= 1

    def test_reference_os_major_version(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert vm.reference_os_major_version == "14"

    def test_reference_os_major_minor_version(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert vm.reference_os_major_minor_version == "14.3"

    def test_os_reference_versions_present(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert "14" in vm.os_reference_versions
        assert "15" in vm.os_reference_versions

    def test_security_patches(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert vm.os_security_patches.get("14.3") == "p5"

    def test_registries_loaded(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert "github" in vm.registries
        assert "local" in vm.registries

    def test_build_environment(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert vm.build_environment["pool_name"] == "zroot"

    def test_image_digests_present(self, project_root):
        vm = load_versions(project_root / "versions.json")
        assert len(vm.image_digests) >= 1
