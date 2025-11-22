#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        golang:1.24.9-freebsd15.0 \
        go version
)
expected_output="go version go1.24.9 freebsd/$(uname -m)"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image golang:1.24.9-freebsd15.0 is valid"
else
    echo "Image golang:1.24.9-freebsd15.0 is not valid"
    exit 1
fi

exit 0