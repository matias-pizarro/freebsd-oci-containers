#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        node:20-freebsd14.3 \
        node --version
)
expected_output="v20.19.5"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image node:20-freebsd14.3 is valid"
else
    echo "Image node:20-freebsd14.3 is not valid"
    # exit 1
fi

exit 0