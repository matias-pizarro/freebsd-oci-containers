#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:14:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1400000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag uv:3-freebsd14.snapshot \
    --tag uv:3.11-freebsd14.snapshot \
    --tag uv:freebsd14.snapshot \
    --file Containerfile