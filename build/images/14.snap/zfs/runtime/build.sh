#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:14:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1400000 \
    --env VERSION_MINOR=snapshot \
    --no-hosts \
    --tag freebsd-zfs:14.snapshot \
    --tag freebsd-zfs:runtime-14.snapshot \
    --file Containerfile