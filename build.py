#!/usr/bin/env -S uv run --script
"""Thin wrapper — delegates to freebsd_containers CLI."""

from freebsd_containers.cli import cli

cli()
