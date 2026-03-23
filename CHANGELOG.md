# Changelog

All notable changes to this project will be documented in this file.

See [Conventional Commits](https://www.conventionalcommits.org/) and
[commitizen](https://commitizen-tools.github.io/commitizen/) for commit
guidelines.

## v0.2.0 (2026-03-23)

### Feat

- add release skill for freebsd-oci-containers
- **scripts/build_all_images.sh**: add a script that builds (naively) all images
- **freebsd/14.3/{base,zfs}**: add a command for the base and zfs images
- **freebsd/14.3/postgres**: adds postgres 13 to 18 images

### Fix

- address third roborev review findings
- address second roborev review findings
- address roborev review findings
- address review findings in release skill
- add --force-exclude to ruff pre-commit hooks
- remove debug breakpoint from build.py

### Refactor

- separate standalone containers from build matrix
- **freebsd/{14,15,16}.snap**: replicate 14.3 files for 14. to 16.snap
