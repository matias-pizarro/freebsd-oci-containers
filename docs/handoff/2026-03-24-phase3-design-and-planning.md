# Handoff: Phase 3 Design & Planning Session

**Date:** 2026-03-24
**Session:** Interactive design + planning for Phase 3 (Streamline Base Image Builds)
**Branch:** `feat/phase3-base-images` (from `integration`)
**Status:** Design and plan complete, awaiting human go/no-go for execution

---

## What Was Done

An interactive session produced two key documents for Phase 3:

1. **Phase 3 design document** — architecture and rationale for Tasks 3.1
   (infra-containers) and 3.2 (build.py refactoring)
2. **Phase 3 execution plan** — detailed step-by-step implementation plan
   for both tasks

Both went through roborev review cycles and human review with amendments.

## Deliverables

| File | Purpose |
|------|---------|
| `docs/design/phase3-design.md` | Phase 3 design doc (Tasks 3.1 + 3.2) |
| `docs/plans/phase3-plan.md` | Detailed execution plan with TDD steps |
| `docs/design/design-principles.md` | Renamed from `vision-and-design.md` |
| `BIBLIOGRAPHY.md` | Updated with Daemonless/dbuild reference |

## Commits on `feat/phase3-base-images`

| Hash | Message |
|------|---------|
| `8a082c5` | docs: add Phase 3 design document |
| `c778074` | fix: address roborev findings in Phase 3 design doc |
| `8504f70` | docs: add VPN CIDR allocation to Phase 3 design |
| `6c48060` | style: replace 'mission' with 'objectives' across docs |
| `119eec5` | refactor: rename vision-and-design.md to design-principles.md |
| `ec48ed9` | docs: add dbuild prior art analysis and expand CLI design |
| `5732f2e` | docs: clarify dual-flavour source-of-truth as key dbuild difference |
| `40d71da` | docs: add Phase 3 execution plan |
| `1c7ec78` | fix: address roborev findings in design doc and execution plan |

## Branch State

```
feat/phase3-base-images (9 commits ahead of integration)
  └── NOT pushed to remote yet
```

**First action on resume: `git push -u origin feat/phase3-base-images`**

## Key Design Decisions

1. **infra-containers follows infra-dklos layered pattern** — L1–L7 Pulumi
   layers, SOPS secrets, bastion SSH, WireGuard VPN

2. **Four server roles:**
   - Gateway (long-lived, bastion/VPN/NAT)
   - Artifact server (long-lived, pkg repo/registry/docs preview)
   - Builder (on-demand, spawn/snapshot/teardown)
   - Test workers (ephemeral, per test run)

3. **Network: `10.102.0.0/16`**, VPN: `172.19.0.0/24` — avoids dklos/rnd
   collision. Known issue: rnd dev VPN CIDRs collide with dklos stg/prod
   (flagged for workspace backlog, not yet committed there)

4. **Builder is on-demand** — defined in `containers:on_demand_servers`
   config section, managed by `bin/spawn-builder`/`bin/teardown-builder`,
   NOT created by `deploy all`

5. **Click for CLI** — `invoke_without_command=True` so bare `build.py`
   stays backward-compatible. Subcommands: `build` (default), `detect`
   (CI matrix JSON), `info` (config overview)

6. **10-module package architecture** — config, versions, tags, digests,
   templates, cicd, docs, builder, cli, __init__

7. **Golden-output verification** — local-only refactoring aid, not
   user-facing; `build_golden/` gitignored and deleted after refactoring

8. **Committed availability manifest** for Python version gating —
   deterministic output; separate update command for pkg catalog queries

9. **dbuild (Daemonless) as prior art** — adopted pipeline model, quality
   gates, CLI patterns; key difference is our dual-flavour generation
   pipeline (upstream Dockerfile + FreeBSD Containerfile) from centralised
   Jinja2 templates + versions.json matrix

10. **Tasks 3.1 and 3.2 execute in parallel** — no mutual dependencies
    until live testing step

## Roborev Findings (All Addressed)

### First review (design doc)
1. ~~Dynamic pkg checks break determinism~~ → Committed availability manifest
2. ~~Artifact server as docs host creates drift~~ → GitHub Pages canonical
3. ~~Global ANN removal breaks legacy files~~ → Scoped to freebsd_containers/

### Second review (plan + design)
1. ~~build_golden/ not available in CI~~ → Clarified as local-only aid
2. ~~Builder contradicts spawn-on-demand~~ → Moved to on_demand_servers
3. ~~Bare build.py breaks with Click~~ → invoke_without_command=True

## Pending Action

**Human go/no-go required before execution begins.**

The human said "capture and persist for hand-off, I have to reboot" before
giving the go/no-go. On resume, present the plan summary and request the
go/no-go decision.

## Execution Strategy (Once Approved)

1. **Task 3.1** (infra-containers): 7 steps — project skeleton → Pulumi
   config → layers L1–L7 → deploy scripts → SOPS secrets → deploy → docs
2. **Task 3.2** (build.py refactoring): 11 steps — env prep → 8 module
   extractions (config, versions, tags, digests, templates, cicd, docs,
   builder) → CLI → thin wrapper

Tasks 3.3–3.9 follow after 3.1 and 3.2 complete.

## File References

- **Design:** `docs/design/phase3-design.md`
- **Plan:** `docs/plans/phase3-plan.md`
- **Spec:** `docs/design/design-principles.md`
- **Prior plan:** `docs/plans/implementation-plan.md`
- **Handoff (prev):** `docs/handoff/2026-03-22-brainstorming-and-planning.md`
- **This handoff:** `docs/handoff/2026-03-24-phase3-design-and-planning.md`

## Workspace Notes

- The VPN CIDR collision (rnd dev vs dklos stg/prod) was identified and
  documented in the design doc. A backlog entry was drafted but NOT
  committed to the workspace repo (different git context). The next
  session working in infra-workspace should add it to `backlog.md`.
