"""Tests for the Click CLI module."""

from __future__ import annotations

from click.testing import CliRunner

from freebsd_containers.cli import cli


class TestCliGroup:
    """Verify CLI group behaviour."""

    def test_bare_invocation_runs_build(self, project_root, tmp_path, monkeypatch):
        """Bare invocation (no subcommand) runs build via invoke_without_command."""
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(cli, ["--build-dir", str(tmp_path / "build")])
        assert result.exit_code == 0
        assert (tmp_path / "build" / "images").exists()

    def test_help_shows_commands(self):
        runner = CliRunner()
        result = runner.invoke(cli, ["--help"])
        assert result.exit_code == 0
        assert "build" in result.output
        assert "detect" in result.output
        assert "info" in result.output


class TestBuildCommand:
    """Verify the build subcommand."""

    def test_build_default(self, project_root, tmp_path, monkeypatch):
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(cli, ["build", "--build-dir", str(tmp_path / "build")])
        assert result.exit_code == 0
        assert (tmp_path / "build" / "mkdocs.yml").exists()

    def test_build_with_project_filter(self, project_root, tmp_path, monkeypatch):
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(
            cli,
            ["build", "--project", "base", "--build-dir", str(tmp_path / "build")],
        )
        assert result.exit_code == 0

    def test_build_with_registry(self, project_root, tmp_path, monkeypatch):
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(
            cli,
            ["build", "--registry", "github", "--build-dir", str(tmp_path / "build")],
        )
        assert result.exit_code == 0


class TestDetectCommand:
    """Verify the detect subcommand."""

    def test_detect_json(self, project_root, monkeypatch):
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(cli, ["detect"])
        assert result.exit_code == 0
        assert "base" in result.output

    def test_detect_github_format(self, project_root, monkeypatch):
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(cli, ["detect", "--format", "github"])
        assert result.exit_code == 0


class TestInfoCommand:
    """Verify the info subcommand."""

    def test_info_shows_projects(self, project_root, monkeypatch):
        monkeypatch.chdir(project_root)
        runner = CliRunner()
        result = runner.invoke(cli, ["info"])
        assert result.exit_code == 0
        assert "Projects" in result.output
