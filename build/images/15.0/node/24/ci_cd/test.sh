#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        node:24-freebsd15.0 \
        node --version
)
expected_output="v24.11.0"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image node:24-freebsd15.0 is valid"
else
    echo "Image node:24-freebsd15.0 is not valid"
    exit 1
fi

exit 0