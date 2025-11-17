#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:16:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1600000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag postgres:18-freebsd16 \
    --tag postgres:18-freebsd16.snapshot \
    --tag postgres:freebsd16 \
    --tag postgres:freebsd16.snapshot \
    --file Containerfile