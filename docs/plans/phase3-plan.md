# Phase 3 Execution Plan

> **For agentic workers:** Use superpowers:executing-plans to implement
> this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Design:** `docs/design/phase3-design.md`
**Spec:** `docs/design/design-principles.md`
**Branch:** `feat/phase3-base-images`

---

## Execution Strategy

Tasks 3.1 (infra-containers) and 3.2 (build.py refactoring) execute **in
parallel** as they have no mutual dependencies until the live testing step.

- **Task 3.1** creates the infrastructure (separate repo: `infra-containers`
  in infra-workspace)
- **Task 3.2** refactors the build system (this repo: `freebsd_containers`)

Each task is broken into steps with TDD, granular commits, and roborev
review checkpoints.

---

## Task 3.1: Set Up infra-containers Project

This task creates a new application project in infra-workspace following
the infra-dklos layered pattern. The work happens in the **infra-containers**
repo, not in freebsd_containers.

### Step 3.1.1: Create project skeleton

**Files to create (in infra-workspace/infra-containers/):**
- `pyproject.toml`
- `Pulumi.yaml`
- `.pre-commit-config.yaml`
- `.gitignore`
- `.roborev.toml`
- `CHANGELOG.md`
- `AGENTS.md`
- `tests/__init__.py`
- `tests/conftest.py`

- [ ] **3.1.1a: Initialise infra-containers directory and git repo**

```bash
cd /agents/worktrees/dkl_infra/hcloud/infra-workspace
mkdir -p infra-containers
cd infra-containers
git init
```

- [ ] **3.1.1b: Create pyproject.toml**

Follow the workspace CLAUDE.md pattern. Key settings:
- `name = "infra-containers"`
- `package = false` (application, not library)
- Dependencies: `infra-hcloud>=0.13.0`, `infra-sops>=0.9.8`,
  `pulumi>=3.0.0,<4.0.0`, `pulumi-hcloud>=1.32.1`
- `[tool.uv.sources]` with editable paths to `../infra-hcloud` and
  `../infra-sops`

- [ ] **3.1.1c: Create Pulumi.yaml**

```yaml
name: containers
description: FreeBSD OCI container build and test infrastructure
runtime:
  name: python
  options:
    toolchain: pip
    virtualenv: .venv
config:
  pulumi:tags:
    value:
      pulumi:template: python
```

- [ ] **3.1.1d: Create .pre-commit-config.yaml, .gitignore, .roborev.toml**

Copy from infra-dklos and adapt project name.

- [ ] **3.1.1e: Create AGENTS.md with project documentation**

Document: project purpose, server roles, layer architecture, network
topology, SSH access patterns, credential loading, deployment workflow.

- [ ] **3.1.1f: Create tests/ skeleton**

Empty `__init__.py` and `conftest.py` with shared fixtures.

- [ ] **3.1.1g: Run `uv sync` and install pre-commit hooks**

```bash
uv sync --group dev --group lint
uv run pre-commit install
```

- [ ] **3.1.1h: Commit**

```
feat: initialise infra-containers project skeleton
```

---

### Step 3.1.2: Create Pulumi stack configuration

**Files to create:**
- `Pulumi.dev.yaml`

- [ ] **3.1.2a: Create Pulumi.dev.yaml with full infrastructure config**

Define the dev environment configuration under the `containers:` namespace.
Key sections:

```yaml
config:
  containers:environment: dev
  containers:pulumi_org: organization
  containers:ssh_key_stack: organization/common/containers__dev
  containers:project: containers
  containers:retain_on_delete: false
  containers:default_ssh_listen_port: 116
  containers:default_location: fsn1
  containers:default_server_type: cx22
  containers:default_image: 351713838

  containers:dns_zones:
    containers.dkl.digital:
      id: <zone_id>

  containers:networks:
    dev:
      ip_range: 10.102.0.0/16
      gateway: gw_ct_dev
      subnets:
        control: {type: cloud, ip_range: 10.102.0.0/24}
        build:   {type: cloud, ip_range: 10.102.1.0/24}
        test:    {type: cloud, ip_range: 10.102.2.0/24}

  containers:volumes:
    ct_artifacts_dev_zfs01: {size: 20}

  containers:servers:
    gw_ct_dev:
      network: dev
      subnet: control
      public_ipv4_enabled: true
      public_ipv6_enabled: true
      role: gateway
      features:
        - is_private_network_gateway
        - is_vpn_host
        - is_vpn_gateway

    ct_artifacts_dev:
      network: dev
      subnet: build
      gateway: gw_ct_dev
      server_type: cx22
      public_ipv4_enabled: false
      role: podman
      volumes: [ct_artifacts_dev_zfs01]
      zfs_pools:
        zdata:
          mountpoint: /data
          local_key: true
          vdevs:
            - single: [ct_artifacts_dev_zfs01]
      features:
        - is_private_network_gateway_client
        - is_container_host
      users:
        mpizarro: {root_access: true, local_user: false}

    ct_builder_dev:
      network: dev
      subnet: build
      gateway: gw_ct_dev
      server_type: cx32
      public_ipv4_enabled: false
      role: podman
      features:
        - is_private_network_gateway_client
        - is_container_host
      users:
        mpizarro: {root_access: true, local_user: false}

  containers:tunnels:
    wg_containers_dev:
      listen_port: 51820
      ipv4_subnet: 172.19.0.0/24
      ipv6_subnet: '2a01:4f8:1c1e:5da3:ac19::0/120'
      mtu: 1420
      persistent_keepalive: 25
      admin: [devops]
      gateways:
        gw_ct_dev: [10.102.0.0/16]
      peered_identities: [mpizarro]
```

- [ ] **3.1.2b: Add tests for project config conformance**

Create `tests/test_project_config.py` validating:
- pyproject.toml structure matches workspace conventions
- Pulumi.yaml uses `virtualenv: .venv`
- Dependencies include infra-hcloud and infra-sops

- [ ] **3.1.2c: Commit**

```
feat: add Pulumi dev stack configuration
```

---

### Step 3.1.3: Create layer programs (L1–L7)

**Files to create:**
- `layers/network/__main__.py` + `Pulumi.yaml`
- `layers/volumes/__main__.py` + `Pulumi.yaml`
- `layers/servers/__main__.py` + `Pulumi.yaml`
- `layers/vpn/__main__.py` + `Pulumi.yaml`
- `layers/services/__main__.py` + `Pulumi.yaml`
- `layers/pods/__main__.py` + `Pulumi.yaml`
- `layers/dns/__main__.py` + `Pulumi.yaml`

- [ ] **3.1.3a: Create L1 network layer**

Follow infra-dklos pattern exactly. The `__main__.py` reads from the
`containers` config namespace and calls `network.build_networks()`.

Each layer Pulumi.yaml follows:
```yaml
name: containers-network
description: "L1: Private networks and subnets for containers"
runtime:
  name: python
  options:
    toolchain: pip
    virtualenv: ../../.venv
```

- [ ] **3.1.3b: Create L2 volumes layer**

Calls `volumes.build_volumes()` from `infra_hcloud.layers`.

- [ ] **3.1.3c: Create L3 servers layer**

The most complex layer. Reads StackReferences from L1 (network), L2
(volumes), and L0 (common). Calls `server.build_servers()`. Generates
DNS records. Decrypts ZFS encryption keys from SOPS.

- [ ] **3.1.3d: Create L4 VPN layer**

Reads L3 server IPs. Configures WireGuard via SSH remote commands.
Unlocks non-local-key ZFS pools.

- [ ] **3.1.3e: Create L5 services layer**

System service configuration via SSH (pf, sysctl, users).

- [ ] **3.1.3f: Create L6 pods layer**

Podman pod deployment. Initial: registry container on artifact server.

- [ ] **3.1.3g: Create L7 DNS layer**

DNS records for services (placeholder initially).

- [ ] **3.1.3h: Commit**

```
feat: add Pulumi layer programs (L1–L7)
```

---

### Step 3.1.4: Create deployment scripts

**Files to create:**
- `bin/deploy.sh`
- `bin/destroy.sh`
- `bin/sops-env`
- `bin/setup-venv`

- [ ] **3.1.4a: Create bin/deploy.sh**

Adapt from infra-dklos. Layer order: network → volumes → servers → vpn →
services → pods → dns. Include refresh, symlink management, ZFS unlock
pre-flight, VPN post-flight.

- [ ] **3.1.4b: Create bin/destroy.sh**

Reverse order: dns → pods → services → vpn → servers → volumes → network.

- [ ] **3.1.4c: Create bin/sops-env**

```bash
#!/usr/bin/env bash
# Exports PULUMI_CONFIG_PASSPHRASE and HCLOUD_TOKEN from SOPS
```

Adapt from infra-dklos, changing project name to `containers`.

- [ ] **3.1.4d: Create bin/setup-venv**

FreeBSD-aware venv creation with `--system-site-packages`.

- [ ] **3.1.4e: Add tests for deploy/destroy scripts**

Test layer ordering, argument validation, symlink management.

- [ ] **3.1.4f: Commit**

```
feat: add deployment and utility scripts
```

---

### Step 3.1.5: Create SOPS secrets

This step requires access to infra-common. Work happens in the
**infra-common** repo.

- [ ] **3.1.5a: Create SOPS secret structure for containers project**

```
infra-common/sops/secrets/projects/containers/dev/
├── deployment/secrets.yaml
├── ssh/deploy_key.yaml
├── vpn/secrets.yaml
└── filesystems/secrets.yaml
```

- [ ] **3.1.5b: Update .sops.yaml with containers project rules**

Add path rules for `secrets/projects/containers/` matching the age
recipients for the containers project.

- [ ] **3.1.5c: Generate deploy SSH key pair**

```bash
ssh-keygen -t ed25519 -C "containers-dev-deploy" -f /tmp/containers_deploy_key
```

Encrypt into `sops/secrets/projects/containers/dev/ssh/deploy_key.yaml`.

- [ ] **3.1.5d: Register SSH key in infra-common Pulumi config**

Add `containers__dev` key reference so the common stack exports it.

- [ ] **3.1.5e: Generate VPN secrets**

```bash
bin/generate-vpn-secrets -c ../infra-containers/Pulumi.dev.yaml
```

- [ ] **3.1.5f: Commit in infra-common**

```
feat: add SOPS secrets for infra-containers project
```

---

### Step 3.1.6: Deploy dev environment

- [ ] **3.1.6a: Load credentials**

```bash
cd infra-containers
eval "$(bin/sops-env -p containers -e dev -s ../infra-common/sops)"
```

- [ ] **3.1.6b: Initialise Pulumi stacks**

```bash
for layer in network volumes servers vpn services pods dns; do
  cd "layers/${layer}"
  uv run pulumi stack init dev
  cd ../..
done
```

- [ ] **3.1.6c: Deploy bottom-up**

```bash
bin/deploy.sh all dev
```

- [ ] **3.1.6d: Verify deployment**

- SSH into gateway via bastion hop
- SSH into artifact server via gateway proxy
- SSH into builder via gateway proxy
- Verify Podman operational: `podman info`
- Verify ZFS pools: `zpool status`
- Verify internet connectivity from private servers

- [ ] **3.1.6e: Run live-test-diagnostics**

```bash
../infra-hcloud/bin/live-test-diagnostics dev --report -v \
  -c . -l ./layers -s ../infra-common/sops
```

- [ ] **3.1.6f: Commit any deployment fixes**

---

### Step 3.1.7: Document live testing workflow

**Files to create (in freebsd_containers):**
- `docs/plans/infra-containers-plan.md` (reference to this plan)

- [ ] **3.1.7a: Write live testing workflow documentation**

Document in AGENTS.md of infra-containers:
1. How to load credentials
2. How to deploy/destroy
3. How to SSH into servers
4. How to build container images on the builder
5. How to test OCI hooks on test workers
6. How to access the artifact server

- [ ] **3.1.7b: Commit**

```
docs: document live testing workflow
```

---

## Task 3.2: Refactor build.py into a Python Package

All work happens in the **freebsd_containers** repo on the
`feat/phase3-base-images` branch.

### Step 3.2.0: Prepare refactoring environment

- [ ] **3.2.0a: Enable type annotations and mypy**

Update `pyproject.toml`:
1. Add `"ANN"` to per-file-ignores for `tests/**/*.py`
2. Remove `"ANN"` from global ignore list
3. Add `mypy>=1.15` to dev dependencies
4. Add `click>=8.1.0` to project dependencies
5. Add `[tool.mypy]` section:
   ```toml
   [tool.mypy]
   python_version = "3.11"
   strict = true
   warn_return_any = true
   warn_unused_configs = true
   ```

```bash
uv sync --group dev --group lint
```

- [ ] **3.2.0b: Capture golden output**

```bash
uv run python build.py
cp -r build/ build_golden/
echo "build_golden/" >> .gitignore
```

- [ ] **3.2.0c: Create package skeleton**

```bash
mkdir -p freebsd_containers
touch freebsd_containers/__init__.py
```

- [ ] **3.2.0d: Commit**

```
chore: enable type annotations (ruff ANN + mypy strict) and add click
```

---

### Step 3.2.1: Extract config module

**Files:**
- Create: `freebsd_containers/config.py`
- Create: `tests/test_config.py`

- [ ] **3.2.1a: Write failing tests for config module**

Test registry config loading, architecture mappings, regex patterns,
build environment settings. Use known values from current build.py.

- [ ] **3.2.1b: Implement config.py**

Extract from build.py:
- `translated_archs` mapping
- `registry_id` and registry selection logic
- All regex patterns (`dollar_prompt_pattern`, `docker_pattern`, etc.)
- `update_base_image_hashes` toggle
- Typed dataclasses: `RegistryConfig`, `BuildEnvironment`, `ArchMapping`

- [ ] **3.2.1c: Update build.py to import from config module**

Replace inline definitions with imports.

- [ ] **3.2.1d: Verify golden output**

```bash
uv run python build.py && diff -r build/ build_golden/
uv run mypy freebsd_containers/
uv run ruff check freebsd_containers/
uv run pytest tests/ -v
```

- [ ] **3.2.1e: Commit**

```
refactor: extract config module from build.py
```

---

### Step 3.2.2: Extract versions module

**Files:**
- Create: `freebsd_containers/versions.py`
- Create: `tests/test_versions.py`

- [ ] **3.2.2a: Write failing tests**

Test versions.json loading, OS version iteration, project version
iteration, reference version resolution, security patch lookups.

- [ ] **3.2.2b: Implement versions.py**

Extract from build.py:
- `versions.json` loading and validation
- OS version parsing (major, minor, patch, short forms)
- Project version parsing (major, minor, patch, port revision)
- Reference version resolution (`os_reference_versions`)
- Security patch lookups (`os_security_patches`)
- Typed dataclasses: `OsVersion`, `ProjectVersion`, `VersionMatrix`

- [ ] **3.2.2c: Update build.py to import from versions module**

- [ ] **3.2.2d: Verify golden output + types + tests**

- [ ] **3.2.2e: Commit**

```
refactor: extract versions module from build.py
```

---

### Step 3.2.3: Extract tags module

**Files:**
- Create: `freebsd_containers/tags.py`
- Create: `tests/test_tags.py`

- [ ] **3.2.3a: Write failing tests**

This is the most complex logic. Write thorough tests using known-good
tag outputs from the golden build. Cover:
- ALL tags (every combination gets full + major.minor tags)
- A tags (reference project version gets major + bare OS tags)
- B tags (reference OS minor version gets major-OS tags)
- C tags (A & B intersection)
- D tags (reference OS major.minor gets OS-free tags)
- E tags (A & D intersection — the "latest" equivalent)

- [ ] **3.2.3b: Implement tags.py**

Extract the tag algebra from build.py lines 262–296. Create a
`generate_tags()` function with typed inputs and outputs.

- [ ] **3.2.3c: Update build.py to import from tags module**

- [ ] **3.2.3d: Verify golden output + types + tests**

- [ ] **3.2.3e: Commit**

```
refactor: extract tags module from build.py
```

---

### Step 3.2.4: Extract digests module

**Files:**
- Create: `freebsd_containers/digests.py`
- Create: `tests/test_digests.py`

- [ ] **3.2.4a: Write failing tests**

Test digest fetching with mocked HTTP responses. Test digest parsing
(OS major/minor, image variants, architecture mappings). Test caching
behaviour.

- [ ] **3.2.4b: Implement digests.py**

Extract from build.py lines 64–97:
- Docker Hub API calls
- Tag data parsing into structured digests
- Architecture-specific digest extraction
- Typed dataclasses: `ImageDigest`, `DigestCache`

- [ ] **3.2.4c: Update build.py to import from digests module**

- [ ] **3.2.4d: Verify golden output + types + tests**

- [ ] **3.2.4e: Commit**

```
refactor: extract digests module from build.py
```

---

### Step 3.2.5: Extract templates module

**Files:**
- Create: `freebsd_containers/templates.py`
- Create: `tests/test_templates.py`

- [ ] **3.2.5a: Write failing tests**

Test template loading, project organisation, Jinja2 rendering,
non-template file copying, upstream docs translation.

- [ ] **3.2.5b: Implement templates.py**

Extract from build.py:
- Jinja2 environment setup
- Template listing and project-grouping logic (lines 36–48)
- Template rendering for project files (lines 382–388)
- Upstream docs copying and translation (lines 162–203)
- Typed interfaces for template context

- [ ] **3.2.5c: Update build.py to import from templates module**

- [ ] **3.2.5d: Verify golden output + types + tests**

- [ ] **3.2.5e: Commit**

```
refactor: extract templates module from build.py
```

---

### Step 3.2.6: Extract CI/CD generator module

**Files:**
- Create: `freebsd_containers/cicd.py`
- Create: `tests/test_cicd.py`

- [ ] **3.2.6a: Write failing tests**

Test script rendering, by_os_version and by_project aggregation,
project-specific vs shared template resolution.

- [ ] **3.2.6b: Implement cicd.py**

Extract from build.py lines 347–379:
- CI/CD script rendering (build, test, push, run_pipeline)
- Aggregation script creation (by_os_version, by_project)
- Source path resolution (project-specific vs shared templates)

- [ ] **3.2.6c: Update build.py to import from cicd module**

- [ ] **3.2.6d: Verify golden output + types + tests**

- [ ] **3.2.6e: Commit**

```
refactor: extract CI/CD generator module from build.py
```

---

### Step 3.2.7: Extract docs generator module

**Files:**
- Create: `freebsd_containers/docs.py`
- Create: `tests/test_docs.py`

- [ ] **3.2.7a: Write failing tests**

Test MkDocs scaffolding, mkdocs.yml rendering, per-project page
generation, upstream docs copying.

- [ ] **3.2.7b: Implement docs.py**

Extract from build.py lines 125–128 and 391–411:
- MkDocs docs directory scaffolding
- mkdocs.yml rendering from project context
- Per-project documentation page generation
- Upstream docs file copying with template rendering

- [ ] **3.2.7c: Update build.py to import from docs module**

- [ ] **3.2.7d: Verify golden output + types + tests**

- [ ] **3.2.7e: Commit**

```
refactor: extract docs generator module from build.py
```

---

### Step 3.2.8: Create builder orchestrator

**Files:**
- Create: `freebsd_containers/builder.py`
- Create: `tests/test_builder.py`

- [ ] **3.2.8a: Write failing tests**

Test the full build workflow: clean → load versions → generate images →
generate CI/CD → generate docs → validate.

- [ ] **3.2.8b: Implement builder.py**

Wire all modules together:
- `build()` function as the main entry point
- Build directory lifecycle management
- Version matrix iteration (the main loop from build.py)
- Context assembly for each (project, version, OS) combination
- Structured logging and build reporting
- Optional project filtering

- [ ] **3.2.8c: Verify golden output + types + tests**

- [ ] **3.2.8d: Commit**

```
refactor: create builder orchestrator wiring all modules
```

---

### Step 3.2.9: Create CLI module

**Files:**
- Create: `freebsd_containers/cli.py`
- Create: `tests/test_cli.py`

- [ ] **3.2.9a: Write failing tests**

Test CLI using Click's `CliRunner`:
- `build` command with default options
- `build --project postgres` (single project)
- `build --validate` (diff against golden)
- `build --dry-run` (no file writes)
- `build --registry github` (registry selection)
- `build --update-digests` (digest refresh)
- `detect` command (JSON matrix output)
- `info` command (config overview)
- `--verbose` / `--quiet` flags

- [ ] **3.2.9b: Implement cli.py**

```python
@click.group()
@click.option("--verbose", "-v", is_flag=True)
@click.option("--quiet", "-q", is_flag=True)
def cli(verbose: bool, quiet: bool) -> None: ...

@cli.command()
@click.option("--project", help="Generate for a single project")
@click.option("--validate", is_flag=True, help="Diff against golden output")
@click.option("--dry-run", is_flag=True, help="Show what would be generated")
@click.option("--registry", default="local", help="Target registry")
@click.option("--update-digests", is_flag=True, help="Refresh base image digests")
def build(...) -> None: ...

@cli.command()
@click.option("--format", type=click.Choice(["json", "github"]), default="json")
def detect(...) -> None: ...

@cli.command()
def info() -> None: ...
```

- [ ] **3.2.9c: Verify golden output + types + tests**

- [ ] **3.2.9d: Commit**

```
feat: add Click CLI with build, detect, and info commands
```

---

### Step 3.2.10: Replace build.py with thin wrapper

**Files:**
- Modify: `build.py`

- [ ] **3.2.10a: Replace build.py**

```python
#!/usr/bin/env -S uv run --script
"""Thin wrapper — delegates to freebsd_containers CLI."""
from freebsd_containers.cli import cli

cli()
```

- [ ] **3.2.10b: Final golden output validation**

```bash
uv run python build.py build
diff -r build/ build_golden/
```

- [ ] **3.2.10c: Run full test suite and type checks**

```bash
uv run pytest tests/ -v
uv run mypy freebsd_containers/
uv run ruff check freebsd_containers/
```

- [ ] **3.2.10d: Clean up build_golden/**

```bash
rm -rf build_golden/
```

- [ ] **3.2.10e: Remove build.py from ruff exclude list**

Update `pyproject.toml`: remove `exclude = ["build.py"]` from
`[tool.ruff]` since it's now a 4-line wrapper.

- [ ] **3.2.10f: Commit**

```
refactor: replace build.py monolith with thin CLI wrapper
```

---

## Review Checkpoints

After completing each major step:

1. Run `uv run pytest tests/ -v` — all tests must pass
2. Run `uv run mypy freebsd_containers/` — strict mode, no errors
3. Run `uv run ruff check` — no lint violations
4. Verify golden output matches (until step 3.2.10)
5. Commit with conventional commit message
6. Run `roborev review --branch --wait` at logical milestones:
   - After 3.2.0 (environment setup)
   - After 3.2.3 (tags — most complex module)
   - After 3.2.8 (builder — full orchestrator)
   - After 3.2.10 (final wrapper)

---

## Completion Criteria

### Task 3.1
- [ ] infra-containers deployed with gateway + artifact server + builder
- [ ] SSH access verified via bastion hop for all servers
- [ ] Podman operational on builder and artifact server
- [ ] ZFS pool functional on artifact server
- [ ] VPN tunnel active and tested
- [ ] Live-test-diagnostics passing
- [ ] Deployment workflow documented in AGENTS.md

### Task 3.2
- [ ] `freebsd_containers/` package with 10 modules, all typed
- [ ] `mypy --strict` passes
- [ ] `ruff check` passes with ANN rules enabled for package
- [ ] `pytest` passes with comprehensive coverage
- [ ] Golden output byte-identical after complete refactoring
- [ ] `build.py` is a 4-line thin wrapper
- [ ] CLI supports: `build`, `detect`, `info` with all documented flags
- [ ] Quality gates: test failures block build completion

### Both tasks
- [ ] All commits use conventional commit format
- [ ] Roborev findings addressed at each checkpoint
- [ ] Documentation updated alongside code changes
