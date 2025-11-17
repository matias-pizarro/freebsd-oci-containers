#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:15:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1500000 \
    --env VERSION_MINOR=0 \
    --no-hosts \
    --tag uv:3-freebsd15 \
    --tag uv:3-freebsd15.0 \
    --tag uv:3.11-freebsd15 \
    --tag uv:3.11-freebsd15.0 \
    --tag uv:freebsd15 \
    --tag uv:freebsd15.0 \
    --file Containerfile