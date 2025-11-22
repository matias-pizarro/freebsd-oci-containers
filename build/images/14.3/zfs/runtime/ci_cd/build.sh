#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:14:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1403000 \
    --env VERSION_MINOR=3 \
    --no-hosts \
    --tag freebsd-zfs \
    --tag freebsd-zfs:14 \
    --tag freebsd-zfs:14.3 \
    --tag freebsd-zfs:runtime \
    --tag freebsd-zfs:runtime-14 \
    --tag freebsd-zfs:runtime-14.3 \
    --file Containerfile