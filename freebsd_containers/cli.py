"""Click CLI for FreeBSD OCI container image generation.

Provides three subcommands:

- ``build`` (default): Generate container images, CI/CD scripts, and docs.
- ``detect``: Output a build matrix as JSON (for CI/CD pipelines).
- ``info``: Show project configuration overview.
"""

from __future__ import annotations

import json
from pathlib import Path

import click

from freebsd_containers.builder import build
from freebsd_containers.versions import load_versions


@click.group(invoke_without_command=True)
@click.option("--verbose", "-v", is_flag=True, help="Enable verbose output.")
@click.option("--quiet", "-q", is_flag=True, help="Suppress non-error output.")
@click.option(
    "--build-dir",
    type=click.Path(),
    default=None,
    help="Output directory (default: ./build).",
)
@click.pass_context
def cli(
    ctx: click.Context,
    verbose: bool,
    quiet: bool,
    build_dir: str | None,
) -> None:
    """FreeBSD OCI container image generation and management."""
    ctx.ensure_object(dict)
    ctx.obj["verbose"] = verbose
    ctx.obj["quiet"] = quiet
    ctx.obj["build_dir"] = Path(build_dir) if build_dir else None

    if ctx.invoked_subcommand is None:
        ctx.invoke(build_cmd)


@cli.command("build")
@click.option("--project", default=None, help="Generate for a single project.")
@click.option("--dry-run", is_flag=True, help="Show what would be generated.")
@click.option("--registry", default="local", help="Target registry.")
@click.option(
    "--update-digests", is_flag=True, help="Refresh base image digests from Docker Hub."
)
@click.option(
    "--build-dir",
    type=click.Path(),
    default=None,
    help="Output directory (overrides group option).",
)
@click.pass_context
def build_cmd(
    ctx: click.Context,
    project: str | None,
    dry_run: bool,
    registry: str,
    update_digests: bool,
    build_dir: str | None,
) -> None:
    """Generate container images, CI/CD scripts, and documentation."""
    base_dir = Path.cwd()

    # Resolve build_dir: command option > group option > default
    resolved_build_dir: Path | None = None
    if build_dir:
        resolved_build_dir = Path(build_dir)
    elif ctx.obj.get("build_dir"):
        resolved_build_dir = ctx.obj["build_dir"]

    if dry_run:
        click.echo("Dry run — would generate build output.")
        return

    build(
        base_dir=base_dir,
        build_dir=resolved_build_dir,
        registry_id=registry,
        update_digests=update_digests,
        project_filter=project,
    )

    if not ctx.obj.get("quiet"):
        click.echo("Build complete.")


@cli.command("detect")
@click.option(
    "--format",
    "output_format",
    type=click.Choice(["json", "github"]),
    default="json",
    help="Output format.",
)
@click.pass_context
def detect_cmd(_ctx: click.Context, output_format: str) -> None:
    """Output CI/CD build matrix as JSON."""
    base_dir = Path.cwd()
    vm = load_versions(base_dir / "versions.json")

    matrix: list[dict[str, str]] = [
        {
            "project": project,
            "version": version,
            "os_major": os_major,
            "os_minor": os_minor,
        }
        for project, p_details in vm.projects.items()
        for version in p_details["versions"]
        for os_major in vm.os_versions
        for os_minor in vm.os_versions[os_major]
    ]

    if output_format == "github":
        click.echo(json.dumps({"include": matrix}))
    else:
        click.echo(json.dumps(matrix, indent=2))


@cli.command("info")
@click.pass_context
def info_cmd(_ctx: click.Context) -> None:
    """Show project configuration overview."""
    base_dir = Path.cwd()
    vm = load_versions(base_dir / "versions.json")

    click.echo("Projects:")
    for name, details in vm.projects.items():
        versions = ", ".join(details["versions"])
        click.echo(f"  {name} ({details['type']}): {versions}")

    click.echo("\nOS Versions:")
    for major, minors in vm.os_versions.items():
        click.echo(f"  FreeBSD {major}: {', '.join(minors.keys())}")

    click.echo(f"\nRegistries: {', '.join(vm.registries.keys())}")
    click.echo(f"Reference OS: {vm.reference_os_major_minor_version}")
