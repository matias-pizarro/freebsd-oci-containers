#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

podman_output=$(
    podman run -it --rm \
        --annotation='sysv=true' \
        postgres:14-freebsd15.snapshot \
        postgres --version
)
expected_output="postgres (PostgreSQL) 14.0"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image postgres:14-freebsd15.snapshot is valid"
else
    echo "Image postgres:14-freebsd15.snapshot is not valid"
    exit 1
fi

exit 0