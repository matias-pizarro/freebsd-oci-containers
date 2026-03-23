---
name: release
description: Use when releasing freebsd-oci-containers from integration to main
---

# Release

Orchestrates the release workflow for freebsd-oci-containers. Two phases:

1. **Merge feature branch to Integration** — lint, test, roborev review, merge
2. **Merge to Main** — version bump, tag, push, cleanup

## Arguments

- **First argument**: `--from-feature <branch>` to include a feature branch merge. Optional.
- **Second argument**: `--integration-only` to stop after Phase 1. Optional.

---

## Phase 1: Merge Feature Branch to Integration

**When to run**: Only when `--from-feature <branch>` is specified. If releasing directly from integration, **skip to Phase 2**.

### 1.1 Checkout Feature Branch

```bash
# Verify clean worktree
if [[ -n "$(git status --porcelain)" ]]; then
    echo "ERROR: Worktree has uncommitted or untracked changes"
    git status --short
    exit 1
fi

git fetch --prune --tags --force origin

# Checkout feature branch (local or remote)
if git show-ref --verify --quiet "refs/heads/${feature_branch}"; then
    git checkout "${feature_branch}"
    if git rev-parse --verify "origin/${feature_branch}" &>/dev/null; then
        LOCAL_HEAD=$(git rev-parse HEAD)
        REMOTE_HEAD=$(git rev-parse "origin/${feature_branch}")
        MERGE_BASE=$(git merge-base HEAD "origin/${feature_branch}")
        if [[ "${LOCAL_HEAD}" == "${REMOTE_HEAD}" ]]; then
            echo "Local and remote branches are in sync"
        elif [[ "${LOCAL_HEAD}" == "${MERGE_BASE}" ]]; then
            git merge --ff-only "origin/${feature_branch}"
        elif [[ "${REMOTE_HEAD}" == "${MERGE_BASE}" ]]; then
            echo "NOTE: Local branch is ahead of remote (unpushed commits)"
        else
            echo "ERROR: Local and remote branches have diverged"
            exit 1
        fi
    fi
else
    git checkout -b "${feature_branch}" "origin/${feature_branch}"
fi
```

### 1.2 Run Linter

```bash
uv run --group lint ruff check . && uv run --group lint ruff format --check .
```

### 1.3 Run Tests

```bash
uv run --group dev pytest tests/ -v
```

If tests fail, iterate until fixed.

### 1.4 Commit Changes (if any)

```bash
if [[ -n "$(git status --porcelain)" ]]; then
    git add -A
    git commit -m "chore: prepare ${feature_branch} for integration merge"
fi
```

### 1.5 Roborev Review

```bash
roborev review --branch --wait
```

Address all findings. Commit fixes. Re-run until review passes.

### 1.6 Update Integration

```bash
git fetch --prune origin
git checkout integration
git merge --ff-only origin/integration

INTEGRATION_COMMIT_AT_MERGE=$(git rev-parse HEAD)
```

### 1.7 Merge Integration into Feature Branch

Merge integration INTO the feature branch first (keeps integration stable):

```bash
git checkout "${feature_branch}"
git merge --no-ff integration -m "chore: merge integration into ${feature_branch}"
```

Resolve conflicts if any.

### 1.8 Post-Merge Validation

```bash
uv run --group lint ruff check . && uv run --group lint ruff format --check .
uv run --group dev pytest tests/ -v
```

If fixes needed, commit and run `roborev review --branch --wait` again.

### 1.9 Check if Integration Advanced

```bash
git fetch --prune origin
git checkout integration
git merge --ff-only origin/integration

CURRENT_INTEGRATION_COMMIT=$(git rev-parse HEAD)
if [[ "${CURRENT_INTEGRATION_COMMIT}" != "${INTEGRATION_COMMIT_AT_MERGE}" ]]; then
    echo "NOTE: Integration has advanced. Returning to step 1.7."
    # Loop back to step 1.7
fi
```

### 1.10 Merge Feature Branch to Integration

```bash
git merge --no-ff "${feature_branch}" -m "chore: merge ${feature_branch} into integration"
```

### 1.11 Push Integration

```bash
git push origin integration
```

**If `--integration-only` was specified, stop here.**

---

## Phase 2: Merge to Main

**Requires human approval for version bump type.**

### 2.1 Prerequisites Check

```bash
git fetch --prune --tags --force origin
git checkout integration
git merge --ff-only origin/integration

# Verify local matches remote
LOCAL_HEAD=$(git rev-parse HEAD)
REMOTE_HEAD=$(git rev-parse origin/integration)
if [[ "${LOCAL_HEAD}" != "${REMOTE_HEAD}" ]]; then
    echo "ERROR: Local integration has unpushed commits."
    exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
    echo "ERROR: Uncommitted changes detected"
    exit 1
fi
```

### 2.2 Run Tests

```bash
uv run --group dev pytest tests/ -v
```

If tests fail, create a fix branch and go through Phase 1 first.

### 2.3 Recommend Version Bump

```bash
LATEST_TAG=$(git tag --merged origin/main -l 'v*' --sort=-v:refname | head -1)

if [[ -n "${LATEST_TAG}" ]]; then
    git log "${LATEST_TAG}"..HEAD --format="%h %s%n%b"
else
    echo "NOTE: No previous tags. This will be the first release."
    git log --format="%h %s%n%b"
fi
```

**Version bump guidelines:**

| Commit Type | Bump |
|-------------|------|
| `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `style:` | patch |
| `feat:` | minor |
| `feat!:` or `BREAKING CHANGE:` in body | major |

**Present recommendation and wait for human approval.**

### 2.4 Bump Version on Integration

```bash
PRE_BUMP_SHA=$(git rev-parse origin/integration)
cz bump --increment <patch|minor|major> --no-verify
LATEST_TAG=$(git describe --tags --abbrev=0)
```

### 2.5 Merge to Main

```bash
git fetch --prune --tags --force origin

# Verify integration hasn't advanced since bump
POST_FETCH_SHA=$(git rev-parse origin/integration)
if [[ "${PRE_BUMP_SHA}" != "${POST_FETCH_SHA}" ]]; then
    echo "ERROR: origin/integration advanced since bump. Stop and investigate."
    exit 1
fi

git checkout main
git merge --ff-only origin/main

# Verify local main matches remote
if [[ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ]]; then
    echo "ERROR: Local main has stray commits. Resolve manually."
    exit 1
fi

git merge --no-ff integration -m "chore: merge integration into main (${LATEST_TAG})"
```

### 2.6 Move Tag to Main

```bash
git tag -f "${LATEST_TAG}" main
```

### 2.7 Return to Integration

```bash
git checkout integration
```

### 2.8 Push

```bash
# Pre-push guard
REMOTE_TAG_SHA=$(git ls-remote --tags origin "refs/tags/${LATEST_TAG}" 2>/dev/null | awk '{print $1}')
LOCAL_TAG_SHA=$(git rev-parse "${LATEST_TAG}" 2>/dev/null)

if [[ -n "${REMOTE_TAG_SHA}" && "${REMOTE_TAG_SHA}" != "${LOCAL_TAG_SHA}" ]]; then
    echo "ERROR: Remote tag ${LATEST_TAG} already exists with different SHA. Investigate."
    exit 1
fi

git push --atomic origin main integration "+refs/tags/${LATEST_TAG}:refs/tags/${LATEST_TAG}"
```

### 2.9 Cleanup

```bash
git fetch --prune origin

# Delete feature branch if used and fully merged
if [[ -n "${feature_branch:-}" ]]; then
    if git show-ref --verify --quiet "refs/remotes/origin/${feature_branch}"; then
        if git merge-base --is-ancestor "origin/${feature_branch}" main; then
            git push origin --delete "${feature_branch}" 2>/dev/null || true
        fi
    fi
    git branch -d "${feature_branch}" 2>/dev/null || true
fi

git fetch --prune origin
```

---

## Examples

```bash
# Release directly from integration (no feature branch)
/release

# Release with a feature branch
/release --from-feature feat/project-rationalization

# Only merge to integration, don't release yet
/release --from-feature feat/project-rationalization --integration-only
```

## Critical Rules

- **NEVER merge main into integration** — one-directional flow only
- **NEVER skip human approval** for version bump type
- **NEVER rebase**
- **ALWAYS run tests** before Phase 2
- **ALWAYS run roborev review** before merging to integration
