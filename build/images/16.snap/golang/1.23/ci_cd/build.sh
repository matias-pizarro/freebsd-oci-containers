#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:16:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1600000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag golang:1.23-freebsd16 \
    --tag golang:1.23-freebsd16.snapshot \
    --tag golang:1.23.12-freebsd16 \
    --tag golang:1.23.12-freebsd16.snapshot \
    --file Containerfile