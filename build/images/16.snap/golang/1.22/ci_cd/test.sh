#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        golang:1.22.12-freebsd16.snapshot \
        go version
)
expected_output="go version go1.22.12 freebsd/$(uname -m)"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image golang:1.22.12-freebsd16.snapshot is valid"
else
    echo "Image golang:1.22.12-freebsd16.snapshot is not valid"
    exit 1
fi

exit 0