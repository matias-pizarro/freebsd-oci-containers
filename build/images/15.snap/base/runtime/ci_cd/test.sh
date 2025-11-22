#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        freebsd-base:runtime-15.snapshot \
        uname -s -U
)
expected_output="FreeBSD 1500"
if [ "${podman_output::12}" == "${expected_output}" ]; then
    echo "Image freebsd-base:runtime-15.snapshot is valid"
else
    echo "Image freebsd-base:runtime-15.snapshot is not valid"
    exit 1
fi

exit 0