#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:15:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1500000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag freebsd-zfs:15.snapshot \
    --tag freebsd-zfs:runtime-15.snapshot \
    --file Containerfile