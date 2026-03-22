# FreeBSD OCI Containers — Vision & Design

## Vision & Mission

FreeBSD OCI Containers aims to build for FreeBSD a comprehensive base of
high-demand application container images — the same building blocks that
underpin most container-based platform and software development across Linux
and macOS.

The project's mission is twofold:

1. **Enable FreeBSD as a first-class container platform** by providing
   production-ready OCI images that let existing containerized projects and
   platforms run on FreeBSD with minimal to no effort.
2. **Contribute FreeBSD support upstream** by tracking and adapting the image
   generation logic of official Docker images, with the goal of submitting
   merge requests that add FreeBSD to official support matrices.

FreeBSD 15.0 introduces mature OCI container support. The missing piece is not
the runtime — it's the ecosystem of application images that developers expect
to find. This project fills that gap.

## Target Users

- **Application developers** who want to deploy existing containerized
  workloads on FreeBSD without rewriting Dockerfiles
- **FreeBSD system administrators** who want idiomatic, FreeBSD-native
  container images that respect the platform's conventions
- **Platform engineers** building container-based infrastructure on FreeBSD
  (e.g., Podman, containerd, jails+OCI hybrid setups)
- **Upstream maintainers** of docker-library projects who want a clean,
  minimal patch set to add FreeBSD support
- **FreeBSD ports maintainers** who may eventually integrate image builds into
  the poudriere CI process

## Image Strategy

Every supported application is provided in two flavours:

### Upstream-compliant (`Dockerfile`)

A drop-in replacement that honours the API, contracts, and documentation of
the official Docker community images. The goal is for a user to swap
`FROM postgres:17` for `FROM freebsd/postgres:17` and have things work. These
images:

- Use the filename `Dockerfile` to signal upstream compatibility
- Track the generation logic of each official docker-library project (e.g.,
  `update.sh`, `apply-templates.sh`)
- Are patched to emit FreeBSD variants while remaining merge-compatible with
  upstream
- Honour the official image documentation, positioning FreeBSD as a low-effort
  additional hosting option
- Serve as the basis for merge requests to upstream projects requesting FreeBSD
  inclusion in their support matrices

Adapting each upstream project's generation logic is a significant
reverse-engineering effort. Each docker-library project has its own generation
logic (often shell scripts like `update.sh` or `apply-templates.sh`). Patching
those to emit FreeBSD variants while staying merge-compatible with upstream
requires careful, per-image work. This is scoped image-by-image, each in its
own dedicated session, starting with the simplest upstreams.

### FreeBSD-flavoured (`Containerfile`)

An idiomatic FreeBSD-centric version that respects FreeBSD conventions for
configuration, directory layout, service management, and tooling. These
images:

- Use the filename `Containerfile` to signal FreeBSD-native identity
- Aim for minimal divergence from the upstream-compliant version, but freely
  depart where doing so delivers significant positive trade-offs
- Follow FreeBSD filesystem hierarchy, rc.conf conventions, and pkg-based
  dependency management
- Serve the FreeBSD community that prefers native approaches over Linux
  compatibility layers

## Tagging Strategy

Understanding and accurately implementing the tagging strategy of each
upstream project is critical. Each docker-library project follows its own
tagging conventions — PostgreSQL uses `17.4`, `17`, `latest`,
`17.4-bookworm`; Node.js uses `22.14.0`, `22.14`, `22`, `lts`, `22-alpine`;
and so on.

Both the upstream-compliant and FreeBSD-flavoured versions must faithfully
reproduce these conventions, adapted for FreeBSD:

- **Upstream-compliant tags** mirror official tags with a FreeBSD qualifier
  (e.g., `17.4-freebsd15.0`, `17-freebsd`)
- **FreeBSD-flavoured tags** use a parallel scheme that signals the native
  variant (e.g., `17.4-freebsd15.0-native`, or a namespace-based approach
  like `freebsd-native/postgres:17.4`)

The exact tagging scheme per image must be defined as part of each image's
implementation session. The `versions.json` matrix must capture the full tag
set for each image x FreeBSD version x project version x flavour combination.

Tag generation is deterministic — driven by `versions.json` and verified by
CI.

## Image Catalog

The image catalog is organized in tiers by priority and dependency:

| Tier | Images | Rationale |
|------|--------|-----------|
| **Foundation** | `base`, `zfs` | All other images build on these. `base` provides the minimal FreeBSD userland; `zfs` adds ZFS dataset support via OCI annotations. |
| **Application** | `postgres`, `node`, `python`, `golang`, `nginx`, `uv` | The highest-demand images that cover the majority of container-based development workflows. Each has a corresponding upstream in docker-library. |
| **Specialty** | `caddy_tls`, `pdfium`, `pkg_cache`, `podman-api`, `poudriere` | Project-specific or niche images that serve particular use cases. Not part of the upstream contribution effort. |

The catalog draws from three sources:

- **[docker-library](https://github.com/docker-library)** — the primary
  source of official image definitions and the target for upstream
  contributions
- **[BastilleBSD templates](https://github.com/BastilleBSD/templates)** —
  FreeBSD jail templates that indicate community demand for specific
  applications
- **[AppJail](https://github.com/DtxdF/AppJail)** — another FreeBSD
  container/jail ecosystem whose application coverage informs image
  prioritization

The catalog is expected to grow over time. New images follow the same
dual-flavour strategy and are added based on community demand and upstream
availability. Note that docker-library is the main source of official image
definitions and documentation, but it is not the only one — some applications
maintain their own independent image projects.

## Build System Architecture

The build system uses a **template-driven code generation** approach:

- **`versions.json`** — a structured version matrix defining every combination
  of image, FreeBSD version, project version, architecture, registry, and
  per-project context (e.g., Yarn versions for Node, codenames for Nginx)
- **`templates/`** — Jinja2 templates for Containerfiles, Dockerfiles, CI/CD
  scripts, and documentation pages
- **`build.py`** — the generation engine that combines `versions.json` with
  templates to produce the `build/` output directory

The generation pipeline produces both flavours:

1. **FreeBSD-side generation**: Our own Jinja2 templates render Containerfiles
   and Dockerfiles with FreeBSD-specific adaptations
2. **Upstream-side generation**: Patched upstream scripts (from `upstreams/`)
   produce Dockerfiles that are merge-compatible with official docker-library
   projects

The `build/` directory is a generated artifact — never committed to version
control. It contains:

- `images/` — Containerfiles and Dockerfiles for every matrix combination
- `ci_cd/` — generated CI/CD pipeline scripts
- `docs/` — generated MkDocs documentation pages

The build system is currently a monolithic script and will be refactored into
a proper Python package (`freebsd_containers/`) with modules for template
rendering, version management, registry configuration, CLI interface, and
tests. The Jinja2 + version matrix architecture is sound and will be
preserved — the implementation needs professionalization.

The effective matrix is four-dimensional: **Image x FreeBSD version x Project
version x Flavour**. The build system must handle this combinatorial space
efficiently and deterministically.

## Documentation

The freebsd_containers documentation website is the **one-stop-shop** covering
all aspects of the generation and use of both image flavours. It is built with
MkDocs Material and published to GitHub Pages.

The documentation has three layers:

1. **Project documentation** — vision, architecture, build system,
   contribution guides, conventions. Written manually and maintained alongside
   code.
2. **Image documentation** — per-image usage guides, configuration reference,
   and examples. Auto-generated by `build.py` from templates, with executable
   code snippets that double as functional tests.
3. **Upstream mirror documentation** — for upstream-compliant images,
   documentation that mirrors the format and content of `docker-library/docs`,
   adapted for FreeBSD. This serves both as our user-facing docs and as the
   basis for documentation PRs to the upstream docs repository.

Documentation follows the Python project and MkDocs conventions established in
the infra-workspace. Exposing and capturing these conventions is one of the
primary reasons the project is developed under infra-workspace.

## Distribution

Images are distributed through multiple channels to maximize reach:

| Channel | Scope | Status |
|---------|-------|--------|
| **Docker Hub** (`docker.io`) | Both flavours | Primary distribution — the default registry for most container users |
| **GitHub Container Registry** (`ghcr.io`) | Both flavours | Native to the project's GitHub home |
| **Quay.io** (`quay.io`) | Both flavours | Additional reach, particularly in enterprise/Red Hat ecosystems |
| **Docker Hub official** | Upstream-compliant only | Long-term goal — FreeBSD images built alongside Linux/macOS in Docker's own CI pipelines |
| **FreeBSD packages** | Both flavours | Long-term goal — images built as part of the poudriere CI process and distributed through the FreeBSD package infrastructure |

The first three channels are under our control and part of the initial build.
The last two are upstream integration goals that depend on the project proving
itself and gaining community traction.

Multi-registry push is handled by generated CI/CD scripts that push to all
configured registries atomically.

## Infrastructure

The project leverages the **infra-hcloud** ecosystem for live testing and
hosting through a dedicated **`infra-containers`** project. The infra-hcloud
codebase is currently private. Open-sourcing it is a short-to-mid-term goal,
targeted for end of Q2 2026.

`infra-containers` is a sibling to `infra-dklos` and `infra-rnd` in the
infra-workspace. It provides:

- **Build infrastructure** — servers for building and testing container images
  across FreeBSD versions and architectures
- **Registry hosting** — optional self-hosted registry for pre-release image
  testing
- **Live testing** — automated deployment and validation of built images
  against real FreeBSD servers
- **CI runners** — infrastructure for running the container build and test
  pipeline

This follows the same Pulumi-based IaC patterns as the other infra-hcloud
application projects, with layered deployment (L1-L7), SOPS-managed secrets,
and bastion-hop SSH access.

The `infra-containers` project is developed separately but is an integral part
of the freebsd_containers ecosystem — every aspect of the container project
can be live-tested and hosted through it.

## Upstream Contribution Path

The strategic goal is for FreeBSD to be included in the official support
matrices of docker-library projects. The contribution path is:

1. **Track upstream generation logic** — for each image, study the official
   docker-library project's `update.sh`, `apply-templates.sh`, or equivalent
   scripts that generate Dockerfiles across versions and architectures
2. **Develop FreeBSD patches** — create minimal, merge-compatible patches that
   add FreeBSD as an additional target alongside existing Linux variants
3. **Prove the images work** — build, test, and distribute FreeBSD images
   independently, demonstrating stability and compatibility
4. **Contribute documentation** — prepare matching documentation PRs for
   `docker-library/docs` following their established format
5. **Submit merge requests** — once images are proven and documented, submit
   PRs to each upstream project requesting FreeBSD inclusion
6. **Integrate into Docker CI** — the ultimate goal is for FreeBSD images to
   be built in the existing Docker CI pipelines and distributed on Docker Hub
   alongside Linux images

This is a per-image effort. Each upstream project has its own generation
logic, conventions, and maintainer expectations. The work is scoped
image-by-image, each in its own dedicated session, starting with the simplest
upstreams and building toward the more complex ones.

The `upstreams/` directory contains forked copies of upstream projects used for
developing and testing these patches.

## FreeBSD Ports Integration

A long-term goal is for FreeBSD ports of each supported project to include the
necessary configuration to build OCI container images as part of the
traditional poudriere-based CI process. This would mean:

- Container images are built as a natural by-product of the FreeBSD
  ports/packages build process
- Images are distributed through the standard FreeBSD package infrastructure
- Updates follow the existing FreeBSD release and security patch cadence

This is a downstream concern. The images must exist, be proven, and gain
community adoption before FreeBSD ports maintainers would consider integrating
them. This goal is stated here to ensure it informs architectural decisions
(e.g., keeping image definitions compatible with ports infrastructure) but is
not part of the initial build effort.

## Conventions

The project follows the Python project and MkDocs conventions established in
the infra-workspace:

- **Python >=3.11**, managed with **uv**
- **Linting**: ruff with `select = ["ALL"]`, Google-style docstrings
- **Formatting**: ruff format (double quotes, 4-space indent, 88-char lines)
- **Testing**: pytest with pytest-mock, TDD approach
- **Commits**: conventional commit format via commitizen
- **Versioning**: semantic versioning, `v$version` tags
- **Pre-commit**: hooks for linting, formatting, commit message validation
- **Documentation**: MkDocs Material with auto-generated content

These conventions are captured in `pyproject.toml` and
`.pre-commit-config.yaml` and mirror the patterns used across all
infra-workspace sub-projects. Exposing these conventions for capture by the
freebsd_containers project is one of the two primary reasons this repo is
developed under infra-workspace.

## Bibliography & Community Resources

The FreeBSD OCI container ecosystem is young and fast-moving. Key community
resources:

- [OCI Containers on FreeBSD](https://freebsdfoundation.org/blog/oci-containers-on-freebsd/) —
  FreeBSD Foundation overview
- [FreeBSD Containers Wiki](https://wiki.freebsd.org/Containers) — community
  wiki tracking container support status
- [OCI + ZFS on FreeBSD](https://people.freebsd.org/~dch/posts/2025-06-27-oci-zfs/) —
  Doug Rabson's work on ZFS-backed containers
- [SkunkWerks documentation](https://docs.skunkwerks.at/s/fUiAmi4pE) —
  community documentation hub
- [Container support matrix](https://docs.google.com/spreadsheets/d/1IGk2uZd2TG3CUddFmWi6_7PygER08n0XlGmronXq0Pk/) —
  tracking spreadsheet for FreeBSD container feature coverage
- [HackMD notes](https://hackmd.io/xA1CxQT8SfKLUpCiQz-tWA) — community
  collaboration notes
- [BastilleBSD templates](https://github.com/BastilleBSD/templates) — FreeBSD
  jail templates indicating application demand
- [AppJail](https://github.com/DtxdF/AppJail) — FreeBSD container/jail
  management with application templates
- [Doug Rabson — OCI on FreeBSD (video)](https://www.youtube.com/watch?v=HV-wUUzRCMo) —
  conference talk on FreeBSD container runtime
