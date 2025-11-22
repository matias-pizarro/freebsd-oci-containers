#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# execute as root or as a user that has privileges
# to run `zfs create` on zroot/test and `podman`
RANDOM_STRING="$(cat /dev/random | head -c 100  | md5sum | head -c 20)"
ZFS_MOUNTPOINT="/tmp/rand${RANDOM_STRING}"
zfs create -p \
    -o jailed=on \
    -o mountpoint="${ZFS_MOUNTPOINT}" \
zroot/test

podman_output=$(
    podman run -it --rm \
        --annotation='zfs.dataset=zroot/test' \
        freebsd-zfs:runtime-15.snapshot \
        zfs list -Ho mountpoint zroot/test
)
expected_output="${ZFS_MOUNTPOINT}"
if [ "${podman_output::-1}" == "${expected_output}" ]; then
    echo "Image freebsd-zfs:runtime-15.snapshot is valid"
else
    echo "Image freebsd-zfs:runtime-15.snapshot is not valid"
    exit 1
fi

zfs destroy -rv zroot/test

exit 0