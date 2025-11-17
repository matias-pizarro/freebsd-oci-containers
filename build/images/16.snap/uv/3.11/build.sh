#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:16:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1600000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag uv:3-freebsd16 \
    --tag uv:3-freebsd16.snapshot \
    --tag uv:3.11-freebsd16 \
    --tag uv:3.11-freebsd16.snapshot \
    --tag uv:freebsd16 \
    --tag uv:freebsd16.snapshot \
    --file Containerfile