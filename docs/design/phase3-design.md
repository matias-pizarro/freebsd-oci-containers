# Phase 3 Design: Streamline Base Image Builds

**Date:** 2026-03-23
**Status:** Draft
**Phase:** 3 of 4
**Depends on:** Phase 2 (completed, merged to `integration`)

---

## 1. Context

Phase 2 aligned the freebsd_containers project with infra-workspace conventions
(pyproject.toml, pre-commit, tests, CI). Phase 3 transforms the proof-of-concept
build system into a production-grade pipeline with live testing, a proper Python
package, and comprehensive documentation.

The project's objectives — enabling FreeBSD as a first-class container platform —
require that every aspect of the build system be testable, reproducible, and
documented to the standard expected of a community-facing open-source project.

---

## 2. Scope

Phase 3 comprises nine tasks (3.1–3.9). This design covers architecture and
rationale for the two highest-priority tasks that will be tackled in parallel:

- **Task 3.1:** Set up `infra-containers` project for live testing
- **Task 3.2:** Refactor `build.py` into a typed Python package

Tasks 3.3–3.9 (documentation, versions.json decision, registry push, multi-arch,
security) follow once 3.1 and 3.2 are complete and will be planned separately.

**Why parallel?** Task 3.1 (infrastructure) and 3.2 (code refactoring) have no
mutual dependencies until the live testing step. Running them concurrently
shortens the critical path: by the time the refactored package is ready for live
validation, the infrastructure is already deployed.

---

## 3. Task 3.1: infra-containers — Live Testing Infrastructure

### 3.1.1 Why

The implementation plan states: *"From Phase 3 onwards, all work must be
validated against a live FreeBSD environment."* Without live testing
infrastructure, we cannot:

- Verify that generated Containerfiles actually build on FreeBSD
- Test OCI annotation hooks (ZFS datasets, SysV IPC) end-to-end
- Validate base image variants (static, dynamic, runtime)
- Run poudriere builds for custom package sets
- Host the container registry and internal docs previews

A dedicated `infra-containers` project provides isolation from dklos/rnd
environments and purpose-built infrastructure for container image development.

### 3.1.2 Architecture

`infra-containers` is a new application project in infra-workspace, following
the infra-dklos layered pattern. It provides four server roles:

#### Server roles

| Role | Purpose | Lifecycle | Spec guidance |
|------|---------|-----------|---------------|
| **Builder** | Image builds, poudriere runs, package compilation | Session-stable: spawned on demand, snapshotted, torn down when idle | Needs CPU + RAM for builds (e.g., CX32 or CX42) |
| **Artifact server** | Internal docs preview, pkg repository, container registry | Long-lived, lightweight | Minimal spec (e.g., CX22), persistent volumes |
| **Test workers** | Transient on-demand servers for image testing, smoke tests, OCI hook validation | Ephemeral: created per test run, destroyed after | Variable spec, created/destroyed programmatically |
| **Gateway** | Bastion SSH, WireGuard VPN, NAT routing for private servers | Long-lived | Minimal (CX22), public IPv4+IPv6 |

#### Why these roles?

- **Builder is session-stable, not permanent.** Container image builds and
  poudriere runs are CPU/RAM-intensive but intermittent. Keeping a large server
  running 24/7 wastes money. The operational model is: spawn with the right
  specs → do the work → snapshot → shut down (or destroy). If the next session
  needs different specs, create a new server from the snapshot or from scratch.
  This is cheaper and more flexible than a permanent build server.

- **Artifact server is long-lived because it serves content.** The package
  repository, container registry, and internal docs preview need to be
  available continuously. A lightweight server with persistent ZFS volumes
  handles this at minimal cost. (The canonical public docs site remains on
  GitHub Pages; the artifact server hosts pre-release previews only.)

- **Test workers are ephemeral by design.** Each test run should start from a
  clean state to avoid test pollution. Workers are created, used, and destroyed.
  This also enables testing against different FreeBSD versions or configurations
  by spinning up purpose-configured workers.

- **Gateway follows the established bastion pattern.** All SSH access goes
  through the gateway. This is a hard security constraint inherited from
  infra-hcloud.

#### Operational model

The infrastructure follows a **spawn-on-demand** model rather than
always-on:

1. **Spawn**: Deploy the builder with appropriate specs for the task
2. **Work**: Build images, run poudriere, test containers
3. **Snapshot**: Capture server state for quick restoration
4. **Shutdown/destroy**: Tear down when finished to save costs
5. **Restore**: Re-create from snapshot or from scratch as needed

The gateway and artifact server are the only permanently running resources.
Everything else is transient. The builder and test workers are defined in a
**separate Pulumi config section** (`containers:on_demand_servers`) so that
routine `deploy all` does not create them — they are managed via dedicated
spawn/teardown scripts (`bin/spawn-builder`, `bin/teardown-builder`).

### 3.1.3 Layer architecture

Following infra-dklos, the Pulumi program is organized into layers:

| Layer | Stack | Contents |
|-------|-------|----------|
| L1 | containers-network | Private network, subnets (control, build, test) |
| L2 | containers-volumes | Persistent volumes for artifact server (ZFS) |
| L3 | containers-servers | Servers, public IPs, DNS records |
| L4 | containers-vpn | WireGuard VPN configuration |
| L5 | containers-services | System services (Podman, ZFS, poudriere, pf) |
| L6 | containers-pods | Container pods and registry setup |
| L7 | containers-dns | DNS records for services |

#### Network topology

```
Internet
    │
    ▼
┌──────────┐  public IPv4/IPv6
│ Gateway   │  10.102.0.2 (control subnet)
│ (gw_ct)   │
└────┬──────┘
     │ NAT + WireGuard
     │
     ├── 10.102.1.0/24 (build subnet)
     │   ├── Builder (ct_builder)     10.102.1.2
     │   └── Artifact (ct_artifacts)  10.102.1.3
     │
     └── 10.102.2.0/24 (test subnet)
         ├── Worker 1 (ct_test_01)    10.102.2.2
         ├── Worker 2 (ct_test_02)    10.102.2.3
         └── ... (on-demand)
```

**Private network range:** `10.102.0.0/16` — chosen to avoid overlap with
dklos (`10.100.0.0/16`) and rnd (`10.101.0.0/16`).

**VPN CIDR:** `172.19.0.0/24` (IPv4) and `2a01:4f8:1c1e:5da3:ac19::0/120`
(IPv6) for the dev tunnel. This follows the dklos allocation sequence
(16/17/18) and avoids collision with rnd (25/26). Full allocation map:

| Project | Env | IPv4 VPN |
|---------|-----|----------|
| dklos | dev | `172.16.0.0/24` |
| dklos | stg | `172.17.0.0/24` |
| dklos | prod | `172.18.0.0/24` |
| **containers** | **dev** | **`172.19.0.0/24`** |
| rnd | stg | `172.25.0.0/24` / `172.26.0.0/24` |

> **Known issue:** rnd dev tunnels (`172.17.0.0/24`, `172.18.0.0/24`) collide
> with dklos stg/prod. Tracked in workspace backlog.

### 3.1.4 Server configuration

All servers run **FreeBSD 15.0** with cloud-init. The builder and test workers
require Podman and ZFS support.

**Builder server features:**
- `is_private_network_gateway_client`
- `is_container_host`
- ZFS pool for build artifacts (`zdata` on attached volumes)
- Poudriere for custom package builds
- Podman for container image builds and testing

**Artifact server features:**
- `is_private_network_gateway_client`
- `is_container_host`
- ZFS pool for persistent storage (docs site, pkg repo, registry)
- nginx serving pre-built static docs (internal preview; GitHub Pages
  remains the canonical public docs host)
- Container registry (distribution/registry or similar)
- pkg repository serving

**Test worker features:**
- `is_private_network_gateway_client`
- `is_container_host`
- Podman + ZFS for OCI hook testing
- Ephemeral (no persistent volumes)

**Gateway features:**
- `is_private_network_gateway`
- `is_vpn_host`
- `is_vpn_gateway`

### 3.1.5 SOPS secrets

Following the infra-common pattern, secrets for the `containers` project are
stored under:

```
infra-common/sops/secrets/projects/containers/
├── dev/
│   ├── deployment/
│   │   └── secrets.yaml      # PULUMI_CONFIG_PASSPHRASE, HCLOUD_TOKEN
│   ├── ssh/
│   │   └── deploy_key.yaml   # SSH deploy key
│   ├── vpn/
│   │   └── secrets.yaml      # WireGuard keys
│   └── filesystems/
│       └── secrets.yaml       # ZFS encryption keys
```

### 3.1.6 Monitoring and logging readiness

The infrastructure is designed to be **monitoring-ready** from day one:

- **Logging**: All servers forward logs via syslog to the artifact server.
  Cloud-init output logged to `/var/log/cloud-init-output.log`. Build logs
  persisted to ZFS volumes on the artifact server.
- **Reporting**: The `live-test-diagnostics` tool (from infra-hcloud) provides
  infrastructure health checks. Build pipeline scripts generate structured
  reports (build success/failure, image sizes, test results).
- **Monitoring hooks**: Server feature flags and pod configurations are
  structured to integrate with monitoring solutions (Prometheus node_exporter,
  Podman healthchecks) when needed. The initial deployment does not include
  active monitoring but the configuration supports adding it without
  architectural changes.

### 3.1.7 Relationship to freebsd_containers

The `infra-containers` project lives in the infra-workspace as a sibling to
infra-dklos and infra-rnd. It is a **separate git repository** with its own
release cycle. The freebsd_containers project references it only through
documentation (how to set up live testing) and operational workflows (deploy →
build → test → push).

The dependency is one-directional: `freebsd_containers` documents how to use
`infra-containers` for live testing, but has no code dependency on it.

---

## 4. Prior Art: Daemonless dbuild

The [Daemonless](https://daemonless.io/) project's
[dbuild](https://daemonless.io/guides/dbuild/) tool
([GitHub](https://github.com/daemonless/dbuild)) is a closely related effort
that builds, tests, and publishes FreeBSD OCI container images. It is a Python
3.11+ CLI (BSD-2-Clause) maintained as a FreeBSD port (`sysutils/py-dbuild`).

dbuild's architecture informs several of our design choices:

| dbuild pattern | Our adoption | Notes |
|----------------|-------------|-------|
| **Build → Test → Publish pipeline** | Adopted | Our builder orchestrator follows the same three-phase model |
| **Multi-variant detection** (`Containerfile`, `Containerfile.<variant>`) | Relevant | Aligns with our dual-flavour strategy (`Dockerfile` + `Containerfile`) |
| **Architecture mapping** (`x86_64`→`amd64`, `arm64`→`aarch64`) | Already present | Same pattern as our `translated_archs` in build.py |
| **CLI subcommands** (`build`, `test`, `push`, `sbom`, `manifest`, `detect`, `info`, `init`) | Partially adopted | We add `detect` (CI matrix output) and `info` (config overview) to our CLI plan |
| **Quality gates blocking pushes** | Adopted | Test failures must block registry pushes |
| **Skip directives** (`[skip test]`, `[skip push]`) | Deferred | Useful for CI; added when CI pipelines mature |
| **SBOM generation** (CycloneDX via trivy + pkg) | Deferred to 3.9 | Relevant to our security baseline task |
| **Config-driven variants** (`.daemonless/config.yaml`) | Different approach | We use `versions.json` for the version matrix; dbuild uses per-project YAML |

**Key differences:**

- **Image definition source of truth.** dbuild treats each image as a
  self-contained project with its own Containerfile(s) authored directly.
  Our project takes a fundamentally different approach: we maintain **two
  canonical sources** per image — an upstream-compliant `Dockerfile` that
  tracks and patches the official docker-library generation logic, and a
  FreeBSD-flavoured `Containerfile` that follows FreeBSD conventions. Both
  are generated from Jinja2 templates combined with the `versions.json`
  matrix. The generation pipeline *is* the source of truth, not the
  generated files. This enables upstream merge compatibility (the
  `Dockerfile` output stays patch-compatible with docker-library projects)
  while simultaneously producing idiomatic FreeBSD images — a dual-flavour
  strategy that dbuild does not attempt.

- **Centralised matrix vs per-image repos.** dbuild targets a
  single-image-at-a-time workflow (one repo per image, CI per repo). Our
  build system generates the full image matrix (Image x FreeBSD version x
  Project version x Flavour) from a centralised version matrix and template
  set. This four-dimensional combinatorial approach ensures consistency
  across the entire image catalog and enables cross-image validation (e.g.,
  verifying that all images build against a new FreeBSD release).

The approaches are complementary — dbuild could potentially be used as the
per-image build executor within our pipeline.

dbuild is added to `BIBLIOGRAPHY.md` as a community resource.

---

## 5. Task 3.2: Refactor build.py into a Python Package

### 5.1 Why

The current `build.py` is a 414-line monolithic script with:

- No type annotations
- No tests (beyond versions.json schema validation)
- Debug output (`pprint`) mixed with production logic
- Hard-coded toggles (`update_base_image_hashes`, `registry_id`)
- Complex tag generation logic that is difficult to verify
- Tightly coupled concerns (digest fetching, template rendering, CI/CD
  generation, docs generation)

For a community-facing OSS project, the build system must be testable,
documented, and maintainable. Refactoring into a proper Python package with
full type annotations enables:

- **TDD**: Each module has its own test suite
- **CI validation**: `mypy --strict` and `ruff check` catch regressions
- **Contributor onboarding**: Clear module boundaries and typed interfaces
- **Golden-output verification**: Byte-identical output at each extraction step

### 5.2 Module architecture

The `freebsd_containers/` package is organized into focused modules:

```
freebsd_containers/
├── __init__.py          # Package metadata, version
├── cli.py               # Click CLI interface
├── config.py            # Registry config, build env, arch mappings, patterns
├── versions.py          # versions.json loading, OS/project version iteration
├── tags.py              # Tag generation logic (versioning schemes)
├── digests.py           # Docker Hub digest fetching and caching
├── templates.py         # Jinja2 template loading and rendering
├── cicd.py              # CI/CD script generation
├── docs.py              # MkDocs documentation generation
└── builder.py           # Orchestrator wiring all modules together
```

#### Why click (not argparse)?

The CLI uses [click](https://click.palletsprojects.com/) rather than argparse:

- **Maintainability**: Decorator-based interface is more readable as the CLI
  grows. Adding subcommands, options, and help text is declarative rather than
  imperative.
- **Evolution**: The CLI will grow to support per-project builds, validation
  modes, dry runs, registry selection, and digest updates. Click's command
  groups and option inheritance handle this cleanly.
- **Community standard**: Click is the de facto standard for Python CLIs in
  the open-source ecosystem. Contributors will recognise the patterns.
- **Testing**: Click's `CliRunner` provides a clean testing interface for
  CLI integration tests.

Click is added as a project dependency (`click>=8.1.0`).

#### Module responsibilities

**config.py** — Static configuration and constants:
- Registry definitions (currently in `versions.json["registries"]`)
- Architecture mappings (`{"amd64": "amd64", "arm64": "aarch64"}`)
- Regex patterns for content transformation
- Build environment settings
- Dataclasses with full type annotations for all config structures

**versions.py** — Version matrix management:
- Load and validate `versions.json`
- Iterate OS versions (major, minor, patch)
- Iterate project versions with reference resolution
- OS reference version and security patch lookups
- Type-safe dataclasses for version entries

**tags.py** — Tag generation:
- Generate the full tag set for each (project, project_version, os_version)
  combination
- Implement the tag algebra (ALL, A, B, C, D, E conditions from build.py
  lines 262-296)
- Deterministic, sorted output
- This is the most intricate logic — thorough test coverage is critical

**digests.py** — Docker Hub digest management:
- Fetch base image digests from Docker Hub API
- Cache results to avoid repeated API calls
- Parse tag data into structured digest mappings
- Support for `--update-digests` CLI flag

**templates.py** — Jinja2 template orchestration:
- Load templates organized by project
- Render Containerfiles, Dockerfiles
- Copy non-template files to build output
- Handle upstream docs translation (Docker → Podman terminology)

**cicd.py** — CI/CD script generation:
- Render build, test, push, run_pipeline scripts
- Create by_os_version and by_project aggregation scripts
- Resolve project-specific vs. shared script templates

**docs.py** — Documentation site generation:
- Scaffold MkDocs docs directory
- Render mkdocs.yml from project context
- Generate per-project documentation pages
- Copy upstream docs with translation

**builder.py** — Build orchestrator:
- Wire all modules together
- Manage build directory lifecycle (clean → generate → validate)
- Provide the main `build()` entry point called by the CLI
- Structured logging and reporting

**cli.py** — Click command interface (using `invoke_without_command=True`
so bare `build.py` invocation runs `build` for backward compatibility):
- `build` command: full generation (default when no subcommand given)
  - `--project <name>`: generate for a single project
  - `--dry-run`: show what would be generated without writing
  - `--registry <id>`: select target registry (default: `local`)
  - `--update-digests`: fetch fresh base image digests from Docker Hub
- `detect` command: output build matrix as JSON for CI consumption
  (inspired by dbuild's `detect --format github`)
- `info` command: human-readable overview of current configuration,
  version matrix, and registry settings
- Global flags: `--verbose` / `--quiet` for output level control

Note: `build_golden/` is a **local-only refactoring aid** used during the
extraction process to verify byte-identical output at each step. It is
gitignored and deleted after refactoring is complete. It is not a
user-facing feature or CI artifact.

### 5.3 Typed Python from day one

All new code in `freebsd_containers/` is fully type-annotated. Before
extracting any modules:

1. **Scope ANN enforcement to new code only**: Rather than removing `"ANN"`
   from the global ruff `ignore` list (which would immediately fail on
   existing unannotated test files), add a per-path override that enables
   ANN rules for `freebsd_containers/` while leaving legacy code untouched:
   ```toml
   [tool.ruff.lint.per-file-ignores]
   "tests/**/*.py" = ["S101", "RUF012", "D104", "ANN"]
   ```
   The global `"ANN"` ignore is removed only after all legacy files are
   migrated.
2. Add `mypy>=1.15` to the `dev` dependency group
3. Add `[tool.mypy]` with `strict = true`
4. Every module must pass `mypy freebsd_containers/` and `ruff check`

The old `build.py` is not retroactively typed — it is progressively replaced.
The ruff `exclude = ["build.py"]` remains until the refactoring is complete.

### 5.4 Golden-output verification

Before refactoring begins, the current build.py output is captured:

```bash
uv run python build.py
cp -r build/ build_golden/
```

After **every** extraction step:

```bash
uv run python build.py
diff -r build/ build_golden/
```

If the diff is non-empty, the extraction introduced a regression. Fix before
proceeding. This catches issues at each step rather than after 10 extraction
steps.

`build_golden/` is added to `.gitignore` and never committed.

### 5.5 Python version gating (dynamic, not hard-coded)

The current build.py hard-codes disabled Python versions:

```python
elif project in ["python", "uv"] and project_version != "3.11":
    build_image = False
```

The refactored code replaces this with **a committed availability manifest**:

- Each project in `versions.json` declares a `buildable_versions` field (or
  equivalent) listing which versions have the required FreeBSD packages
  available
- The build system reads this manifest to determine `build_image` — no live
  package catalog queries during generation, preserving deterministic output
- A separate **update command** (`freebsd-containers update-availability`)
  queries the FreeBSD pkg catalog and proposes updates to the manifest
- Updates are reviewed and committed explicitly, so the same commit always
  produces the same output regardless of external package repository state
- As new Python versions become available in FreeBSD ports, the update
  command detects them; as older versions are removed, it flags them

This preserves the golden-output determinism guarantee (section 5.4) while
making version gating self-maintaining through deliberate, reviewable updates
rather than hard-coded exclusions.

### 5.6 Logging and reporting

The refactored package replaces ad-hoc `print()` and `pprint()` calls with
structured logging:

- Python `logging` module with configurable levels
- `--verbose` enables DEBUG, default is INFO, `--quiet` suppresses to WARNING
- Build reports summarise: images generated, tags created, scripts rendered,
  docs pages built
- Errors and warnings are structured for CI parsing

### 5.7 TDD approach

Each module extraction follows the red-green-refactor cycle:

1. **Red**: Write failing tests for the module's expected behaviour
2. **Green**: Extract code from build.py into the module until tests pass
3. **Refactor**: Clean up, add type annotations, verify golden output
4. **Commit**: One commit per extraction step (at minimum)

Test files mirror the module structure:

```
tests/
├── test_config.py
├── test_versions.py
├── test_tags.py
├── test_digests.py
├── test_templates.py
├── test_cicd.py
├── test_docs.py
├── test_builder.py
└── test_cli.py
```

---

## 6. Design Decisions Summary

| # | Decision | Rationale |
|---|----------|-----------|
| D1 | infra-containers follows infra-dklos layered pattern | Proven architecture, consistent with workspace conventions |
| D2 | Four server roles (builder, artifacts, workers, gateway) | Separates concerns: build vs serve vs test vs access |
| D3 | Spawn-on-demand operational model for builder/workers | Cost-efficient for intermittent, resource-intensive workloads |
| D4 | Long-lived artifact server with persistent ZFS volumes | Continuous availability for docs, packages, and registry |
| D5 | `10.102.0.0/16` network range | Avoids overlap with dklos (10.100) and rnd (10.101) |
| D6 | Click for CLI framework | Maintainability, evolution, community standard, test support |
| D7 | 10-module package architecture | Single-responsibility, testable, typed modules |
| D8 | Golden-output verification at each step | Catches regressions immediately, not after 10 steps |
| D9 | Committed availability manifest for version gating | Deterministic output; self-maintaining via explicit update command |
| D10 | Structured logging replacing print/pprint | Production-grade observability, CI-friendly output |
| D11 | Tasks 3.1 and 3.2 in parallel | No mutual dependencies until live testing step |
| D12 | FreeBSD sysadmin audience for documentation | Primary user base per project design principles |
| D13 | Docs as MkDocs templates (not standalone markdown) | Consistent with existing generated documentation site |
| D14 | Monitoring-ready from day one | Logging, reporting, and hook points without active monitoring overhead |
| D15 | dbuild as prior art reference | Adopt pipeline model, quality gates, and CLI patterns; diverge on centralised matrix approach |
| D16 | Quality gates block registry pushes | Test failures must prevent image publication (adopted from dbuild) |

---

## 7. Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| infra-containers SOPS setup blocks deployment | Cannot live-test | Ensure secrets are created early; can test 3.2 without infra |
| build.py has undocumented side effects | Golden output diverges | Capture golden output before any changes; diff at every step |
| Tag generation logic is more complex than it appears | Subtle regressions | Thorough test suite with known-good tag outputs per project |
| Click dependency adds to install requirements | Heavier package | Click is lightweight (~100KB); worth the maintainability gain |
| Poudriere setup is complex on FreeBSD 15.0 | Builder provisioning delays | Start with Podman-only builds; add poudriere incrementally |

---

## 8. Out of Scope

The following are explicitly **not** part of this design:

- Tasks 3.3–3.9 (documented separately after 3.1 and 3.2 complete)
- Phase 4 per-image updates
- Active monitoring deployment (infrastructure is monitoring-ready but no
  Prometheus/Grafana/etc.)
- Multi-architecture builds (documented in 3.8, executed later)
- Registry push automation (documented in 3.7, executed later)

---

## 9. Success Criteria

### Task 3.1
- [ ] infra-containers project deployed with gateway + artifact server
- [ ] SSH access verified via bastion hop
- [ ] Podman operational on at least one server
- [ ] ZFS pools functional for persistent storage
- [ ] Builder can be spawned and torn down on demand

### Task 3.2
- [ ] `freebsd_containers/` package with all 10 modules
- [ ] `mypy --strict` passes on all modules
- [ ] `ruff check` passes (ANN rules enabled)
- [ ] `pytest` passes with >80% coverage on new code
- [ ] Golden output matches after complete refactoring
- [ ] `build.py` is a thin wrapper calling `freebsd_containers.cli`
- [ ] CLI supports `build` (default), `detect`, `info` with documented flags
