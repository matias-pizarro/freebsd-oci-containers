#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        node:25-freebsd15.snapshot \
        node --version
)
expected_output="v25.1.0"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image node:25-freebsd15.snapshot is valid"
else
    echo "Image node:25-freebsd15.snapshot is not valid"
    exit 1
fi

exit 0