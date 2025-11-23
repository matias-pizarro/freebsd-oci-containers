#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        --annotation='sysv=true' \
        postgres:18-freebsd14.3 \
        postgres --version
)
expected_output="postgres (PostgreSQL) 18.0"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image postgres:18-freebsd14.3 is valid"
else
    echo "Image postgres:18-freebsd14.3 is not valid"
    exit 1
fi

exit 0