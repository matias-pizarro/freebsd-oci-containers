"""Shared test fixtures for freebsd_containers tests."""

import json
from pathlib import Path

import pytest

PROJECT_ROOT = Path(__file__).resolve().parent.parent


@pytest.fixture
def project_root():
    """Return the project root directory."""
    return PROJECT_ROOT


@pytest.fixture
def versions():
    """Load and return the parsed versions.json."""
    versions_file = PROJECT_ROOT / "versions.json"
    with versions_file.open() as f:
        return json.load(f)
