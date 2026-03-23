# Handoff: Brainstorming & Planning Session

**Date:** 2026-03-22
**Session:** Interactive brainstorming + design + implementation planning
**Branch:** `partial_versioning_refactor`
**Status:** Planning complete, ready for execution

---

## What Was Done

An interactive brainstorming session produced two key documents:

1. **Design principles document** — long-term objectives, design decisions,
   and architectural principles for the FreeBSD OCI Containers project
2. **Implementation plan** — detailed four-phase plan covering tooling
   alignment, base image streamlining, and per-image upstream updates

Both documents went through automated spec/plan review loops and human
review with amendments.

## Deliverables

| File | Purpose |
|------|---------|
| `docs/design/design-principles.md` | Design principles doc (also `README.md` via symlink, future MkDocs index) |
| `docs/plans/implementation-plan.md` | Detailed 4-phase implementation plan |

## Commits

| Hash | Message |
|------|---------|
| `18cb74b` | docs: add vision and design document |
| `6ea52de` | docs: address spec review findings and add roadmap |
| `55a2f0b` | docs: symlink README.md to vision and design document |
| `cba1793` | docs: incorporate human review amendments |
| `d6c7f47` | docs: add implementation plan |
| `e69245c` | docs: address plan review findings |
| `6a0cc6b` | docs: make live testing a Phase 3 prerequisite |
| `7ed48db` | docs: add typed Python requirement to build.py refactoring task |

## Key Design Decisions

1. **Community-facing OSS project** — not internal tooling. High bar on
   code quality, documentation, and professional presence.

2. **Dual-flavour image strategy:**
   - Upstream-compliant (`Dockerfile`) — drop-in replacement, target
     upstream merge requests to docker-library projects
   - FreeBSD-flavoured (`Containerfile`) — idiomatic FreeBSD conventions,
     minimal divergence from upstream-compliant

3. **Standalone repo** — already has its own GitHub repo
   (`freebsd-oci-containers`), independent release cycle and CI/CD.
   Lives under infra-workspace only for convention capture and
   infra-hcloud leverage.

4. **FreeBSD 15.0+ only** — 14.x dropped from supported versions.

5. **versions.json needs review** — may be refactored or deprecated in
   favour of a better solution. Decision deferred to Task 3.6.

6. **build.py is a monolithic PoC** — will be refactored into a proper
   `freebsd_containers/` Python package with typed code (mypy strict).

7. **agent_sandbox shelved** — moved to jails-based solution.

## Execution Plan Summary

### Phase 2: Align Tooling (Tasks 2.1–2.12)

Start from a clean `main` branch. Bring the project into infra-workspace
conformance:

- `.gitignore`, `pyproject.toml`, `.pre-commit-config.yaml`, `CHANGELOG.md`
- `tests/` with versions.json validation and `conftest.py`
- Separate standalone containers from build matrix
- Clean up ancillary files (PROJECTS.md → BIBLIOGRAPHY.md)
- GitHub Actions validation CI
- Community files (CONTRIBUTING.md, CODE_OF_CONDUCT.md)

### Phase 3: Streamline Base Images (Tasks 3.1–3.9)

**Task 3.1 is the prerequisite:** Set up `infra-containers` hcloud project
for live testing. From this point, all work must be validated on live
FreeBSD servers.

- **Task 3.2 (biggest):** Refactor `build.py` into `freebsd_containers/`
  package — 8 modules, CLI, full type annotations (mypy strict + ruff ANN),
  golden-output verification at each extraction step
- OCI annotation hook documentation
- Base and ZFS image build guides
- Local reproducibility workflow
- versions.json structure decision
- Registry push workflow, multi-arch strategy, security baseline

### Phase 4: Per-Image Updates (repeatable template)

8 images in priority order:

1. `base` → 2. `zfs` → 3. `postgres` → 4. `python` → 5. `node` →
6. `golang` → 7. `nginx` → 8. `uv`

Each image follows an 8-step template: update versions.json → study
upstream → update FreeBSD Containerfile → develop upstream-compliant
Dockerfile → update docs → validate tags → build & push → prepare
upstream contribution.

## Execution Approach

**Subagent-driven** via `mcp__chic__spawn_agent`. Fresh agent per task,
review between tasks.

## Key Constraints

- **Fresh start from `main`** for Phase 2 execution
- **Live testing required** from Phase 3 onwards (infra-containers hcloud)
- **Typed Python** — all new code fully type-annotated (mypy strict)
- **Never rebase**, conventional commits, `--no-ff` merges
- **TDD** — write failing tests first, then implement
- **Granular commits** — at least one per logical step

## File References

- **Spec:** `docs/design/design-principles.md`
- **Plan:** `docs/plans/implementation-plan.md`
- **Audit:** `docs/reviews/2026-02-18_audit_review.md`
- **Rationalization plan:** `docs/reviews/2026-02-18_rationalization_plan.md`
- **This handoff:** `docs/handoff/2026-03-22-brainstorming-and-planning.md`
