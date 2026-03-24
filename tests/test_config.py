"""Tests for the config module."""

from __future__ import annotations

import re

from freebsd_containers.config import (
    ARCH_MAP,
    COMPOSE_PATTERN,
    DOCKER_PATTERN,
    DOLLAR_PROMPT_PATTERN,
    HASH_PATTERN,
    HASH_REPLACEMENT,
    IMAGE_PATTERN,
    LOGO_PATTERN,
    RegistryConfig,
    get_registry,
)


class TestArchMap:
    """Verify architecture mapping."""

    def test_amd64_maps_to_amd64(self):
        assert ARCH_MAP["amd64"] == "amd64"

    def test_arm64_maps_to_aarch64(self):
        assert ARCH_MAP["arm64"] == "aarch64"

    def test_exactly_two_architectures(self):
        assert len(ARCH_MAP) == 2


class TestRegexPatterns:
    """Verify compiled regex patterns match expected inputs."""

    def test_dollar_prompt_pattern_matches(self):
        assert DOLLAR_PROMPT_PATTERN.search("$ ls -la")

    def test_dollar_prompt_pattern_no_match(self):
        assert not DOLLAR_PROMPT_PATTERN.search("no prompt here")

    def test_docker_pattern_matches_word(self):
        assert DOCKER_PATTERN.search("run docker build")

    def test_docker_pattern_no_match_in_substring(self):
        assert not DOCKER_PATTERN.search("dockerfile")

    def test_compose_pattern_matches_bare(self):
        assert COMPOSE_PATTERN.search("%%COMPOSE%%")

    def test_compose_pattern_matches_commented(self):
        assert COMPOSE_PATTERN.search("## %%COMPOSE%%")

    def test_image_pattern_matches(self):
        assert IMAGE_PATTERN.search("%%IMAGE%%")

    def test_logo_pattern_matches(self):
        assert LOGO_PATTERN.search("%%LOGO%%")

    def test_hash_pattern_matches_heading(self):
        match = HASH_PATTERN.search("## Hello")
        assert match is not None
        assert match.group(1) == "## "

    def test_hash_replacement_adds_level(self):
        result = re.sub(HASH_PATTERN, HASH_REPLACEMENT, "## Title")
        assert result == "### Title"


class TestRegistryConfig:
    """Verify RegistryConfig dataclass."""

    def test_from_dict_full(self):
        data = {
            "name": "ghcr.io",
            "slug": "github",
            "icon": "simple/github",
            "username": "user",
            "project": "proj",
        }
        reg = RegistryConfig.from_dict(data)
        assert reg.name == "ghcr.io"
        assert reg.slug == "github"
        assert reg.username == "user"
        assert reg.project == "proj"

    def test_from_dict_nulls(self):
        data = {"name": None, "username": None, "project": None}
        reg = RegistryConfig.from_dict(data)
        assert reg.name is None
        assert reg.username is None
        assert reg.project is None

    def test_prefix_with_all_parts(self):
        reg = RegistryConfig(
            name="ghcr.io",
            username="user",
            project="proj",
        )
        assert reg.prefix == "ghcr.io/user/proj/"

    def test_prefix_with_no_parts(self):
        reg = RegistryConfig(name=None, username=None, project=None)
        assert reg.prefix == ""

    def test_prefix_with_some_parts(self):
        reg = RegistryConfig(name="docker.io", username="user", project=None)
        assert reg.prefix == "docker.io/user/"


class TestGetRegistry:
    """Verify registry loading from versions.json data."""

    def test_get_known_registry(self, versions):
        reg = get_registry("github", versions["registries"])
        assert reg.name == "ghcr.io"

    def test_get_local_registry(self, versions):
        reg = get_registry("local", versions["registries"])
        assert reg.name is None

    def test_get_unknown_registry_raises(self, versions):
        import pytest

        with pytest.raises(KeyError):
            get_registry("nonexistent", versions["registries"])
