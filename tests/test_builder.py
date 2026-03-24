"""Tests for the builder orchestrator module."""

from __future__ import annotations

from freebsd_containers.builder import build


class TestBuild:
    """Verify the full build workflow."""

    def test_build_produces_output(self, project_root, tmp_path):
        """Build produces the expected directory structure."""
        build_dir = tmp_path / "build"
        build(
            base_dir=project_root,
            build_dir=build_dir,
            registry_id="local",
            update_digests=False,
        )
        assert build_dir.exists()
        assert (build_dir / "images").exists()
        assert (build_dir / "docs").exists()
        assert (build_dir / "ci_cd").exists()
        assert (build_dir / "mkdocs.yml").exists()

    def test_build_creates_image_dirs(self, project_root, tmp_path):
        """Build creates directories for each OS+project combination."""
        build_dir = tmp_path / "build"
        build(
            base_dir=project_root,
            build_dir=build_dir,
            registry_id="local",
            update_digests=False,
        )
        images_dir = build_dir / "images"
        # Should have at least one OS version directory
        os_dirs = list(images_dir.iterdir())
        assert len(os_dirs) >= 1

    def test_build_creates_containerfiles(self, project_root, tmp_path):
        """Build renders Containerfiles for buildable images."""
        build_dir = tmp_path / "build"
        build(
            base_dir=project_root,
            build_dir=build_dir,
            registry_id="local",
            update_digests=False,
        )
        # Find at least one Containerfile
        containerfiles = list(build_dir.rglob("Containerfile"))
        assert len(containerfiles) >= 1

    def test_build_creates_cicd_scripts(self, project_root, tmp_path):
        """Build creates CI/CD aggregation scripts."""
        build_dir = tmp_path / "build"
        build(
            base_dir=project_root,
            build_dir=build_dir,
            registry_id="local",
            update_digests=False,
        )
        assert (build_dir / "ci_cd" / "by_os_version").exists()
        assert (build_dir / "ci_cd" / "by_project").exists()

    def test_build_with_project_filter(self, project_root, tmp_path):
        """Build with project filter only generates that project."""
        build_dir = tmp_path / "build"
        build(
            base_dir=project_root,
            build_dir=build_dir,
            registry_id="local",
            update_digests=False,
            project_filter="base",
        )
        # Should have images but only for base
        images_dir = build_dir / "images"
        assert images_dir.exists()
        for os_dir in images_dir.iterdir():
            project_dirs = list(os_dir.iterdir())
            for pd in project_dirs:
                assert pd.name == "base"

    def test_build_cleans_existing_output(self, project_root, tmp_path):
        """Build removes existing build directory before generating."""
        build_dir = tmp_path / "build"
        build_dir.mkdir()
        (build_dir / "stale_file.txt").write_text("stale")
        build(
            base_dir=project_root,
            build_dir=build_dir,
            registry_id="local",
            update_digests=False,
        )
        assert not (build_dir / "stale_file.txt").exists()
