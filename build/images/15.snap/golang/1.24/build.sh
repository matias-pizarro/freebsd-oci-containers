#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:15:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1500000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag golang:1.24-freebsd15.snapshot \
    --tag golang:1.24.9-freebsd15.snapshot \
    --file Containerfile