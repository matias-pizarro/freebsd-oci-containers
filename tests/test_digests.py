"""Tests for the digests module — Docker Hub API and digest parsing."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest

from freebsd_containers.config import ARCH_MAP
from freebsd_containers.digests import (
    fetch_digests,
    merge_digests_into_os_versions,
    parse_tag_response,
)


def _make_tag_result(
    name: str = "14.3",
    digest: str = "sha256:aaa",
    tag_last_pushed: str = "2025-01-01T00:00:00Z",
    images: list | None = None,
) -> dict:
    """Build a Docker Hub tag result dict."""
    if images is None:
        images = [
            {"architecture": "amd64", "digest": "sha256:bbb"},
            {"architecture": "arm64", "digest": "sha256:ccc"},
        ]
    return {
        "name": name,
        "digest": digest,
        "tag_last_pushed": tag_last_pushed,
        "images": images,
    }


class TestParseTagResponse:
    """Verify parsing of Docker Hub tag API responses."""

    def test_basic_parsing(self):
        tags = [_make_tag_result()]
        result = parse_tag_response(tags, ARCH_MAP)
        assert "14" in result
        assert "3" in result["14"]
        assert result["14"]["3"]["tag_last_pushed"] == "2025-01-01T00:00:00Z"

    def test_arch_mapping(self):
        tags = [_make_tag_result()]
        result = parse_tag_response(tags, ARCH_MAP)
        # amd64 → amd64, arm64 → aarch64
        assert result["14"]["3"]["static"]["amd64"] == "sha256:bbb"
        assert result["14"]["3"]["static"]["aarch64"] == "sha256:ccc"

    def test_index_digest_stored(self):
        tags = [_make_tag_result(digest="sha256:idx")]
        result = parse_tag_response(tags, ARCH_MAP)
        assert result["14"]["3"]["static"]["index"] == "sha256:idx"

    def test_snapshot_version(self):
        tags = [_make_tag_result(name="16.snap")]
        result = parse_tag_response(tags, ARCH_MAP)
        assert "16" in result
        assert "snapshot" in result["16"]

    def test_multiple_image_versions(self):
        """Three calls (static, dynamic, runtime) produce separate keys."""
        tags_static = [_make_tag_result()]
        result = parse_tag_response(tags_static, ARCH_MAP, image_version="static")
        assert "static" in result["14"]["3"]

        tags_dynamic = [_make_tag_result()]
        result_d = parse_tag_response(tags_dynamic, ARCH_MAP, image_version="dynamic")
        assert "dynamic" in result_d["14"]["3"]

    def test_tag_last_pushed_not_overwritten(self):
        """First tag's tag_last_pushed wins; later tags don't overwrite."""
        tags = [
            _make_tag_result(name="14.3", tag_last_pushed="2025-01-01T00:00:00Z"),
        ]
        result = parse_tag_response(tags, ARCH_MAP)
        # Call again — should keep first value
        second_tags = [
            _make_tag_result(name="14.3", tag_last_pushed="2025-06-01T00:00:00Z"),
        ]
        result2 = parse_tag_response(
            second_tags, ARCH_MAP, image_version="dynamic", existing=result
        )
        assert result2["14"]["3"]["tag_last_pushed"] == "2025-01-01T00:00:00Z"


class TestFetchDigests:
    """Verify fetch_digests with mocked HTTP."""

    @patch("freebsd_containers.digests.requests.get")
    def test_fetches_three_image_versions(self, mock_get):
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = {
            "results": [_make_tag_result()],
        }
        mock_get.return_value = mock_response

        result = fetch_digests(ARCH_MAP)
        assert mock_get.call_count == 3  # static, dynamic, runtime
        assert "14" in result

    @patch("freebsd_containers.digests.requests.get")
    def test_http_error_raises(self, mock_get):
        mock_response = MagicMock()
        mock_response.status_code = 500
        mock_response.raise_for_status.side_effect = Exception("Server Error")
        mock_get.return_value = mock_response

        with pytest.raises(Exception, match="Server Error"):
            fetch_digests(ARCH_MAP)


class TestMergeDigests:
    """Verify digest merging into os_versions."""

    def test_merge_replaces_empty_digests(self):
        os_versions = {
            "14": {
                "3": {
                    "static": {"amd64": "", "aarch64": ""},
                    "dynamic": {"amd64": "", "aarch64": ""},
                    "runtime": {"amd64": "", "aarch64": ""},
                },
            },
        }
        image_digests = {
            "14": {
                "3": {
                    "static": {
                        "amd64": "sha256:aaa",
                        "aarch64": "sha256:bbb",
                        "index": "sha256:ccc",
                    },
                    "dynamic": {
                        "amd64": "sha256:ddd",
                        "aarch64": "sha256:eee",
                        "index": "sha256:fff",
                    },
                    "runtime": {
                        "amd64": "sha256:ggg",
                        "aarch64": "sha256:hhh",
                        "index": "sha256:iii",
                    },
                    "tag_last_pushed": "2025-01-01T00:00:00Z",
                },
            },
        }
        merge_digests_into_os_versions(os_versions, image_digests)
        assert os_versions["14"]["3"]["static"]["amd64"] == "sha256:aaa"
        assert os_versions["14"]["3"]["runtime"]["index"] == "sha256:iii"

    def test_merge_handles_missing_digest(self):
        os_versions = {
            "15": {
                "0.beta5": {
                    "static": {"amd64": "", "aarch64": ""},
                },
            },
        }
        # No matching digest for 15.0.beta5
        image_digests = {}
        # Should not raise
        merge_digests_into_os_versions(os_versions, image_digests)
        assert os_versions["15"]["0.beta5"]["static"]["amd64"] == ""
