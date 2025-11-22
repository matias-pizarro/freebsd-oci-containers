#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:16:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1600000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag node:24-freebsd16 \
    --tag node:24-freebsd16.snapshot \
    --tag node:freebsd16 \
    --tag node:freebsd16.snapshot \
    --file Containerfile