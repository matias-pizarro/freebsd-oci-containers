#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

./build.sh

# execute as root or as a user that has privileges
# to run `zfs create` on zroot/test${RANDOM_STRING} and `podman`
# PostgreSQL-optimized ZFS dataset
# Based on Klara Systems best practices:
# - recordsize=8K matches PostgreSQL's 8KiB page size (critical for performance)
# - compression=lz4 provides 2-3x compression with minimal CPU overhead
# - atime=off eliminates unnecessary metadata writes
# - logbias=latency optimizes for database write patterns
# See: https://klarasystems.com/articles/openzfs-storage-best-practices-and-use-cases-part-3-databases-and-vms/
doas zfs create -p \
    -o jailed=on \
    -o mountpoint="/var/cache/pkg_cache/varnish" \
    -o recordsize=8K \
    -o compression=lz4 \
    -o atime=off \
    -o logbias=latency \
    -o sync=standard \
zroot/var/cache/pkg_cache/varnish

podman run -dt --replace \
    --restart=always \
    --log-driver=none \
    --log-opt mode=non-blocking \
    --name pkg_cache.proxy \
    --publish 8000:80 \
    --annotation='zfs.dataset=zroot/var/cache/pkg_cache/varnish' \
    pkg_cache

# doas zfs destroy -rv protection_zroot/var/cache/pkg_cache/varnish
