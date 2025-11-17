#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:14:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1403000 \
    --env VERSION_MINOR=3 \
    --no-hosts \
    --tag node:24-freebsd \
    --tag node:24-freebsd14 \
    --tag node:24-freebsd14.3 \
    --tag node:freebsd \
    --tag node:freebsd14 \
    --tag node:freebsd14.3 \
    --file Containerfile