# FreeBSD OCI Containers

## Context and Objectives

FreeBSD OCI Containers aims to build for FreeBSD a comprehensive base of
high-demand application container images, the same building blocks that
underpin most container-based platform and software development across Linux
and macOS.

The project's mission is twofold:

1. **Enable FreeBSD as a first-class container platform** by providing
   production-ready OCI images that let existing containerized projects and
   platforms run on FreeBSD with minimal to no effort.
2. **Contribute FreeBSD support upstream** by tracking and adapting the image
   generation logic of official Docker images, with the goal of submitting
   merge requests that add FreeBSD to official support matrices.

FreeBSD 15.0 introduces mature OCI container support. Now that
the runtime is available it is critical to develop the ecosystem of application
images that developers expect to find. This project aims to help fill that gap.

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
the official Docker community images. The eventual goal is for a user to be able
to use `FROM postgres:17` on FreeBSD. The intermediate goal is for that user to
swap `FROM postgres:17` for `FROM freebsd/postgres:17` and have things work.
These images:

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

### A note on filenames

The OCI image specification does not mandate either filename, `Dockerfile` is
Docker's convention, `Containerfile` is Podman's. The choice here is
deliberate: `Dockerfile` signals "this works like the official Docker image
you already know"; `Containerfile` signals "this is built the FreeBSD way."
Both are standard OCI images and work with any compliant runtime.

### Compatibility Contract

For upstream-compliant images, "drop-in replacement" means specifically:

- **Entrypoint and CMD** : same default entrypoint and command as the official
  image (e.g., `docker-entrypoint.sh` for PostgreSQL)
- **Environment variables** : same configuration variables with the same
  semantics (e.g., `POSTGRES_PASSWORD`, `POSTGRES_DB`)
- **Exposed ports** : same default ports (e.g., 5432 for PostgreSQL)
- **Volume mount points** : same data directories (e.g., `/var/lib/postgresql/data`)
- **Configuration file locations** : same paths where applicable
- **Signal handling** : same graceful shutdown behaviour
- **Health checks** : equivalent health check mechanisms

FreeBSD-flavoured images may diverge on any of these where the FreeBSD
convention provides a better experience (e.g., using `/var/db/postgres`
instead of `/var/lib/postgresql/data`). Divergences are documented per image.

## Base Image Architecture

All images build on the foundation `base` and `zfs` images. These are not
versioned by application version, instead they provide three variants that
serve different use cases:

| Variant | Contents | Use case |
|---------|----------|----------|
| **static** | Statically-linked FreeBSD base utilities only | Minimal base for images that bring their own runtime (e.g., Go binaries) |
| **dynamic** | Dynamically-linked FreeBSD base with shared libraries | Base for images that need the FreeBSD shared library ecosystem |
| **runtime** | Full FreeBSD userland with pkg manager | Base for images that install packages at build time (e.g., PostgreSQL, Python) |

The `zfs` variant extends any of these with ZFS dataset support via OCI
annotations (see below). Downstream images declare which base variant they
build on, the choice depends on their runtime requirements.

## OCI Annotations and Runtime Hooks

FreeBSD's OCI container runtime supports custom annotations that enable
features not available on Linux. This project provides and documents two
annotation hooks:

### ZFS dataset mounting

The `zfs` annotation hook allows containers to mount persistent ZFS datasets
directly, leveraging FreeBSD's native ZFS support. A container can declare
a dataset via OCI annotations, and the runtime hook handles dataset creation,
jailing (`zfs set jailed=on`), and mount management. This enables:

- Persistent storage with ZFS snapshots, compression, and quotas
- Dataset-per-container isolation
- Zero-copy data sharing between host and container

### SysV IPC

The `sysv` annotation hook enables System V IPC (shared memory, semaphores,
message queues) inside containers. This is required by applications like
PostgreSQL that use SysV shared memory for performance.

### Hook installation

The runtime hooks are distributed as JSON configuration files and shell
scripts in the `annotations/hooks.d/` directory. They are installed to
`/usr/local/etc/containers/hooks.d/` on the host and activated by configuring
`hooks_dir` in `containers.conf`. See `annotations/` for detailed setup
instructions.

## Tagging Strategy

Understanding and accurately implementing the tagging strategy of each
upstream project is critical. Each docker-library project follows its own
tagging conventions that must be faithfully reproduced for both flavours.

Both the upstream-compliant and FreeBSD-flavoured versions reproduce upstream
conventions, adapted for FreeBSD:

- **Upstream-compliant tags** mirror official tags with a FreeBSD qualifier
  (e.g., `17.4-freebsd15.0`, `17-freebsd`)
- **FreeBSD-flavoured tags** use a parallel scheme that signals the native
  variant (e.g., `17.4-freebsd15.0-native`, or a namespace-based approach
  like `freebsd-native/postgres:17.4`)

The exact tagging scheme per image is defined in `versions.json` via the
`versioning_scheme` field. Tag generation is deterministic and verified by CI.

### Worked example: PostgreSQL

PostgreSQL's `versioning_scheme` is `M[.m][-OSn[OSmm]]`, which produces:

| Pattern | Example tags |
|---------|-------------|
| `M` | `17` : latest minor of major version 17 |
| `M.m` | `17.7` : specific minor version |
| `M-OSn` | `17-freebsd15` : major version on FreeBSD 15 |
| `M.m-OSnOSmm` | `17.7-freebsd15.0` : fully qualified |

For the upstream-compliant flavour, these mirror Docker Hub's official
PostgreSQL tags with a FreeBSD suffix. For the FreeBSD-flavoured variant,
the scheme is extended with a `-native` qualifier or served under a separate
namespace.

## Architecture Support

The project targets the following architectures:

| Architecture | Status | Notes |
|-------------|--------|-------|
| **amd64** | Primary | Full support, all images |
| **aarch64** (arm64) | Secondary | Supported where FreeBSD and upstream packages are available |
| **riscv64** | Experimental | Tracked in `versions.json` for future readiness |

Multi-architecture OCI manifests are produced so that a single tag (e.g.,
`freebsd/postgres:17`) resolves to the correct architecture automatically.
The `os_versions` matrix in `versions.json` tracks base image digests per
architecture.

## Image Catalog

The image catalog is organized in tiers by priority and dependency:

| Tier | Images | Rationale |
|------|--------|-----------|
| **Foundation** | `base`, `zfs` | All other images build on these. `base` provides the minimal FreeBSD userland in three variants (static, dynamic, runtime); `zfs` adds ZFS dataset support via OCI annotations. |
| **Application** | `postgres`, `node`, `python`, `golang`, `nginx`, `uv` | The highest-demand images that cover the majority of container-based development workflows. Each has a corresponding upstream in docker-library. |
| **Specialty** | `caddy_tls`, `pdfium`, `pkg_cache`, `podman-api`, `poudriere` | Project-specific or niche images that serve particular use cases. Not part of the upstream contribution effort. |

The catalog draws from three sources:

- **[docker-library](https://github.com/docker-library)** : the primary
  source of official image definitions and the target for upstream
  contributions
- **[BastilleBSD templates](https://github.com/BastilleBSD/templates)** :
  FreeBSD jail templates that indicate community demand for specific
  applications
- **[AppJail](https://github.com/DtxdF/AppJail)** : another FreeBSD
  container/jail ecosystem whose application coverage informs image
  prioritization

The catalog is expected to grow over time. New images follow the same
dual-flavour strategy and are added based on community demand and upstream
availability. Note that docker-library is the main source of official image
definitions and documentation, but it is not the only one  as some applications
maintain their own independent image projects.

### Supported FreeBSD versions

The image matrix currently covers:

| Version | Type | Status |
|---------|------|--------|
| **15.0** | Release | Stable, Primary target for upstream contributions |
| **15.snapshot** | Snapshot | Tracking builds |
| **16.snapshot** | Snapshot | Experimental, future readiness |

## Build System Architecture

The build system uses a **template-driven code generation** approach:

- **`versions.json`** : a structured version matrix defining every combination
  of image, FreeBSD version, project version, architecture, registry, and
  per-project context (e.g., Yarn versions for Node, codenames for Nginx). Needs
  reviewing and possible refactoring or deprecation in favour of a better
  solution.
- **`templates/`** : Jinja2 templates for Containerfiles, Dockerfiles, CI/CD
  scripts, and documentation pages
- **`build.py`** : the generation engine that combines `versions.json` with
  templates to produce the `build/` output directory. The curren monolithic
  proof-of-concept needs to be refactored into a testable and
  streamlined collection of modules.

### Dual generation pipeline

The build system produces both flavours through two complementary paths:

1. **FreeBSD-side generation** produces **both** `Containerfile`
   (FreeBSD-flavoured) and `Dockerfile` (upstream-compliant) using our own
   Jinja2 templates with FreeBSD-specific adaptations. This is the primary
   generation path for all images.
2. **Upstream-side generation** uses patched upstream scripts (from
   `upstreams/`) to produce Dockerfiles that are merge-compatible with
   official docker-library projects. This path validates that our patches
   produce correct output and serves as the basis for upstream PRs.

The `build/` directory is a generated artifact and never committed to version
control. It contains:

- `images/` : Containerfiles and Dockerfiles for every matrix combination
- `ci_cd/` : generated CI/CD pipeline scripts
- `docs/` : generated MkDocs documentation pages

### Build system roadmap

The build system is currently a monolithic script and will be refactored into
a proper Python package (`freebsd_containers/`) with modules for template
rendering, version management, registry configuration, CLI interface, and
tests. The Jinja2 + version matrix architecture is sound and will be
preserved but the implementation needs industrialization.

The effective matrix is four-dimensional: **Image x FreeBSD version x Project
version x Flavour**. The build system must handle this combinatorial space
efficiently and deterministically.

## Testing Strategy

Testing operates at multiple levels:

### Build system tests

Unit and integration tests for `build.py` (and its successor package) verify
that template rendering, version matrix expansion, and tag generation produce
correct, deterministic output. CI runs the generation step and validates that
output matches expectations, detecting drift between templates and generated
artifacts.

### Container image build tests

Every generated Containerfile and Dockerfile must build successfully. CI
builds images for each matrix combination and reports failures. This catches
missing packages, broken templates, and FreeBSD version incompatibilities.

### Runtime smoke tests

Each image includes executable documentation snippets that double as smoke
tests. For each image, these verify:

- The container starts and the primary process runs
- The documented environment variables are respected
- The documented ports are listening
- Basic application functionality works (e.g., `SELECT 1` for PostgreSQL,
  `node -e "console.log('ok')"` for Node.js)

### Upstream compatibility tests

For upstream-compliant images, tests verify that the image behaves identically
to the official Docker image where possible. This includes entrypoint
behaviour, environment variable handling, and default configuration.

### Live testing

The `infra-containers` project (see Infrastructure below) provides real
FreeBSD servers for end-to-end validation. The goal is for anyone to be able
to reproduce the full test suite locally with a clear, documented setup
process.

## Documentation

The freebsd_containers documentation website is the **one-stop-shop** covering
all aspects of the generation and use of both image flavours. It is built with
MkDocs Material and published to GitHub Pages.

The documentation has three layers:

1. **Project documentation** : objectives, architecture, build system,
   contribution guides, conventions. Written manually and maintained alongside
   code.
2. **Image documentation** : per-image usage guides, configuration reference,
   and examples. Auto-generated by `build.py` from templates, with executable
   code snippets that double as functional tests.
3. **Upstream mirror documentation** : for upstream-compliant images,
   documentation that mirrors the format and content of `docker-library/docs`,
   adapted for FreeBSD. This serves both as our user-facing docs and as the
   basis for documentation PRs to the upstream docs repository.

Documentation follows the Python project and MkDocs conventions established in
the infra-workspace (see Conventions below).

## Distribution

Images are distributed through multiple channels to maximize reach:

| Channel | Scope | Status |
|---------|-------|--------|
| **Docker Hub** (`docker.io`) | Both flavours | Primary distribution, the default registry for most container users |
| **GitHub Container Registry** (`ghcr.io`) | Both flavours | Native to the project's GitHub home |
| **Quay.io** (`quay.io`) | Both flavours | Additional reach, particularly in enterprise/Red Hat ecosystems |
| **Docker Hub official** | Upstream-compliant only | Long-term goal, FreeBSD images built alongside Linux/macOS in Docker's own CI pipelines |
| **FreeBSD packages** | Both flavours | Long-term goal, images built as part of the poudriere CI process and distributed through the FreeBSD package infrastructure |

The first three channels are under our control and part of the initial build.
The last two are upstream integration goals that depend on the project proving
itself and gaining community traction.

Multi-registry push is handled by generated CI/CD scripts that push to all
configured registries atomically.

## Infrastructure

The project leverages the **infra-hcloud** ecosystem for live testing and
development through a dedicated **`infra-containers`** project. The infra-hcloud
codebase is currently private. Open-sourcing it is a short-to-mid-term goal,
targeted for end of Q2 2026.

`infra-containers` is a sibling to `infra-dklos` and `infra-rnd` in the
infra-workspace. It provides:

- **Build infrastructure** : servers for building and testing container images
  across FreeBSD versions and architectures
- **Registry hosting** : optional self-hosted registry for pre-release image
  testing
- **Live testing** : automated deployment and validation of built images
  against real FreeBSD servers
- **CI runners** : infrastructure for running the container build and test
  pipeline

This follows the same Pulumi-based IaC patterns as the other infra-hcloud
application projects, with layered deployment (L1-L7), SOPS-managed secrets,
and bastion-hop SSH access.

The `infra-containers` project is developed separately but is an integral part
of the freebsd_containers ecosystem, every aspect of the container project
can be live-tested and hosted through it.

## Upstream Contribution Path

The strategic goal is for FreeBSD to be included in the official support
matrices of docker-library projects. The contribution path is:

1. **Track upstream generation logic** : for each image, study the official
   docker-library project's `update.sh`, `apply-templates.sh`, or equivalent
   scripts that generate Dockerfiles across versions and architectures
2. **Develop FreeBSD patches** : create minimal, merge-compatible patches that
   add FreeBSD as an additional target alongside existing Linux variants
3. **Prove the images work** : build, test, and distribute FreeBSD images
   independently, demonstrating stability and compatibility
4. **Contribute documentation** : prepare matching documentation PRs for
   `docker-library/docs` following their established format
5. **Submit merge requests** : once images are proven and documented, submit
   PRs to each upstream project requesting FreeBSD inclusion
6. **Integrate into Docker CI** : the ultimate goal is for FreeBSD images to
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

This is a downstream concern. The mechanism to integrate this as part of the
broader FreeBSD ports platform needs to be aligned. This goal is stated here to
ensure it informs architectural decisions (e.g., keeping image definitions
compatible with ports infrastructure) but is not part of the initial build
effort.

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
infra-workspace sub-projects. Exposing these conventions for capture is one
reason the project is developed under infra-workspace. The other is to
leverage infra-hcloud through the `infra-containers` project for live testing
and hosting (see Infrastructure above).

## Roadmap

### Phase 1: Capture context, objectives and high-level plan

Capture the long-term objectives and design decisions in project documentation.
This document serves as both the community-facing project description and the
ground truth for development work.

### Phase 2: Align tooling with infra-workspace conventions

Bring the Python project structure, MkDocs configuration, pre-commit hooks,
and CI setup into full conformance with infra-workspace conventions. Clean up
audit findings (remove tracked artifacts, fix build.py hygiene, add tests).
Start from a clean `main` branch.

### Phase 3: Streamline base image builds

Streamline and improve the documentation and process for base image builds.
Document OCI annotation hooks thoroughly. Set up live testing environments
via `infra-containers` with a clear aim for anyone to reproduce locally.
Establish the end-to-end workflow: template -> build -> test -> publish.

### Phase 4: Update upstream projects one by one

Bring each upstream project up to spec, one at a time. For each image:

1. Study the upstream docker-library generation logic
2. Update the FreeBSD-flavoured Containerfile and documentation
3. Develop upstream-compliant Dockerfile patches
4. Build, test, and validate both flavours
5. Publish to registries (Docker Hub, GHCR, Quay)
6. When ready, prepare upstream merge request

Priority order follows the image catalog tiers: foundation images first
(base, zfs), then application images (postgres, node, python, golang, nginx,
uv), then specialty images as needed.

## Security Considerations

As a project distributing container images, supply chain security is a
concern from the outset:

- **Base image pinning** : base images are pinned by SHA256 digest in
  `versions.json`, ensuring reproducible builds
- **Image signing** : image signing and provenance attestation (SLSA) are
  planned for the distribution pipeline
- **Vulnerability scanning** : automated scanning of built images is planned
  as part of CI
- **Minimal attack surface** : the static and dynamic base variants minimize
  the installed package set

## License

The project is released under the **BSD 2-Clause License**. See `LICENSE` for
the full text. Note that upstream images may carry their own licenses (e.g.,
PostgreSQL License, MIT, Apache 2.0), the FreeBSD container images inherit
the license terms of their respective application software.

## Bibliography & Community Resources

The FreeBSD OCI container ecosystem is young and fast-moving. Key community
resources:

- [Podman OCI Containers on FreeBSD](https://docs.skunkwerks.at/s/fUiAmi4pE):
  community documentation hub (canonical)
- [OCI + ZFS on FreeBSD](https://people.freebsd.org/~dch/posts/2025-06-27-oci-zfs/):
  Dave Cottlehuber's work on ZFS-backed containers (canonical)
- [FreeBSD Cloud Native Container Technologies Working Group - workstreams](https://docs.google.com/spreadsheets/d/1IGk2uZd2TG3CUddFmWi6_7PygER08n0XlGmronXq0Pk/):
  tracking spreadsheet for FreeBSD container feature coverage (community-maintained)
- [FreeBSD Cloud Native Container Technologies Working Group - meeting notes](https://hackmd.io/xA1CxQT8SfKLUpCiQz-tWA): community
  collaboration notes (community-maintained)
- [Doug Rabson: OCI on FreeBSD (video)](https://www.youtube.com/watch?v=HV-wUUzRCMo):
  conference talk on FreeBSD container runtime
