"""Tests for versions.json schema validation."""

import re


class TestTopLevelStructure:
    """Verify versions.json has required top-level keys."""

    REQUIRED_KEYS = {
        "build_environment",
        "registries",
        "projects",
        "os_versions",
        "os_reference_versions",
    }

    def test_file_exists(self, project_root):
        """Verify versions.json exists in the project root."""
        assert (project_root / "versions.json").exists()

    def test_required_keys_present(self, versions):
        """Verify all required top-level keys are present."""
        missing = self.REQUIRED_KEYS - set(versions.keys())
        assert not missing, f"Missing top-level keys: {missing}"


class TestRegistries:
    """Verify registry configuration structure."""

    REQUIRED_FIELDS = {"name", "username", "slug"}

    def test_at_least_one_registry(self, versions):
        """Verify at least one registry is configured."""
        assert len(versions["registries"]) >= 1

    def test_public_registries_have_required_fields(self, versions):
        """Verify public registries have name, username, and slug."""
        for reg_id, registry in versions["registries"].items():
            if reg_id == "local":
                continue  # local registry allows null values
            missing = self.REQUIRED_FIELDS - set(registry.keys())
            assert not missing, f"Registry {reg_id} missing: {missing}"
            for field in self.REQUIRED_FIELDS:
                assert registry[field] is not None, (
                    f"Registry {reg_id}.{field} must not be null"
                )


class TestProjects:
    """Verify project definitions."""

    REQUIRED_FIELDS = {"name", "slug", "type", "versions"}
    UPSTREAM_REQUIRED = {"upstreams", "ready_for_upstream_merge"}
    VALID_TYPES = {"os_variant", "upstream_adaptation"}

    def test_at_least_one_project(self, versions):
        """Verify at least one project is defined."""
        assert len(versions["projects"]) >= 1

    def test_project_has_required_fields(self, versions):
        """Verify every project has the required fields."""
        for name, project in versions["projects"].items():
            missing = self.REQUIRED_FIELDS - set(project.keys())
            assert not missing, f"Project {name} missing: {missing}"

    def test_project_type_is_valid(self, versions):
        """Verify every project type is os_variant or upstream_adaptation."""
        for name, project in versions["projects"].items():
            assert project["type"] in self.VALID_TYPES, (
                f"Project {name} has invalid type: {project['type']}"
            )

    def test_upstream_projects_have_upstream_fields(self, versions):
        """Verify upstream_adaptation projects have upstreams and merge flag."""
        for name, project in versions["projects"].items():
            if project["type"] == "upstream_adaptation":
                missing = self.UPSTREAM_REQUIRED - set(project.keys())
                assert not missing, f"Upstream project {name} missing: {missing}"
                assert isinstance(project["ready_for_upstream_merge"], bool)

    def test_versions_is_nonempty_list(self, versions):
        """Verify every project has a non-empty versions list."""
        for name, project in versions["projects"].items():
            assert isinstance(project["versions"], list), (
                f"Project {name}: versions must be a list"
            )
            assert len(project["versions"]) >= 1, (
                f"Project {name}: versions must not be empty"
            )

    def test_reference_project_version_in_versions(self, versions):
        """Verify reference_project_version matches a version entry."""
        for name, project in versions["projects"].items():
            if "reference_project_version" in project:
                ref = project["reference_project_version"]
                # Reference may be a prefix (e.g., "1.25" matches "1.25.4")
                matches = [v for v in project["versions"] if v.startswith(ref)]
                assert matches, (
                    f"Project {name}: reference_project_version '{ref}' "
                    f"not found in versions"
                )


class TestOsVersions:
    """Verify OS version matrix structure."""

    def test_at_least_one_os_major(self, versions):
        """Verify at least one OS major version is defined."""
        assert len(versions["os_versions"]) >= 1

    def test_os_versions_have_minor_versions(self, versions):
        """Verify each OS major version has at least one minor version."""
        for major, minors in versions["os_versions"].items():
            assert isinstance(minors, dict), (
                f"OS {major}: minor versions must be a dict"
            )
            assert len(minors) >= 1, f"OS {major}: must have at least one minor version"

    def test_os_reference_versions_consistency(self, versions):
        """Verify reference versions point to existing OS versions."""
        refs = versions["os_reference_versions"]
        assert "reference_os_major_version" in refs
        for major in refs:
            if major == "reference_os_major_version":
                continue
            assert major in versions["os_versions"], (
                f"Reference OS {major} not in os_versions"
            )


class TestImageDigests:
    """Verify image digest format when present."""

    DIGEST_PATTERN = re.compile(r"^sha256:[a-f0-9]{64}$")

    def test_digests_are_valid_format(self, versions):
        """Verify all non-empty digest entries match sha256 format."""
        if "image_digests" not in versions:
            return
        self._check_digests_recursive(versions["image_digests"], "image_digests")

    def _check_digests_recursive(self, obj, path):
        """Recursively check digest values in nested dicts."""
        if isinstance(obj, dict):
            for key, value in obj.items():
                self._check_digests_recursive(value, f"{path}.{key}")
        elif isinstance(obj, str) and obj.startswith("sha256:"):
            assert self.DIGEST_PATTERN.match(obj), (
                f"Digest at {path} has invalid format: {obj}"
            )
