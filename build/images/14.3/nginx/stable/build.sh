#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:14:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1403000 \
    --env VERSION_MINOR=3 \
    --no-hosts \
    --tag nginx:freebsd \
    --tag nginx:freebsd14 \
    --tag nginx:freebsd14.3 \
    --tag nginx:stable-freebsd \
    --tag nginx:stable-freebsd14 \
    --tag nginx:stable-freebsd14.3 \
    --file Containerfile