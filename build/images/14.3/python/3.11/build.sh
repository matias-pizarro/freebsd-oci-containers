#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman build \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:14:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=1403000 \
    --env VERSION_MINOR=3 \
    --no-hosts \
    --tag python:3-freebsd \
    --tag python:3-freebsd14 \
    --tag python:3-freebsd14.3 \
    --tag python:3.11-freebsd \
    --tag python:3.11-freebsd14 \
    --tag python:3.11-freebsd14.3 \
    --tag python:freebsd \
    --tag python:freebsd14 \
    --tag python:freebsd14.3 \
    --file Containerfile