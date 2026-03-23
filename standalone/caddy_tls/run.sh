#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# ./build.sh

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
    -o mountpoint="/var/cache/caddy_tls" \
    -o recordsize=8K \
    -o compression=lz4 \
    -o atime=off \
    -o logbias=latency \
    -o sync=standard \
zroot/var/cache/caddy_tls

# staging: https://acme-staging-v02.api.letsencrypt.org/directory
# prod:    https://acme-v02.api.letsencrypt.org/directory
export HETZNER_AUTH_API_TOKEN=$(cat ~/.config/pat/hetzner.cloud | grep "dkl_website_rw=" | awk -F '"' '{print $2}')
podman run -it --replace \
    --restart=never \
    --log-driver=none \
    --log-opt mode=non-blocking \
    --name caddy_tls \
    --env DOMAIN_NAME=DOMAIN_NAME \
    --env HETZNER_AUTH_API_TOKEN=${HETZNER_AUTH_API_TOKEN} \
    --env IDENTIFIERS=IDENTIFIERS \
    --env CERT_AUTHORITY=https://acme-staging-v02.api.letsencrypt.org/directory \
    --env ACME_ACCOUNT=ACME_ACCOUNT \
    --annotation='zfs.dataset=zroot/var/cache/caddy_tls' \
    caddy_tls

# doas zfs destroy -rv protection_zroot/var/cache/caddy_tls/varnish
