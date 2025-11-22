#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:15:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1500000 \
    --env VERSION_MINOR=0 \
    --no-hosts \
    --tag golang:1.23-freebsd15 \
    --tag golang:1.23-freebsd15.0 \
    --tag golang:1.23.12-freebsd15 \
    --tag golang:1.23.12-freebsd15.0 \
    --file Containerfile