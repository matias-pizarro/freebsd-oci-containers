#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:15.snapshot"
podman tag localhost/freebsd-zfs:15.snapshot "${IMAGE_PATH}"/freebsd-zfs:15.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:15.snapshot

echo
echo "freebsd-zfs:runtime-15.snapshot"
podman tag localhost/freebsd-zfs:runtime-15.snapshot "${IMAGE_PATH}"/freebsd-zfs:runtime-15.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:15.snapshot"
podman tag localhost/freebsd-zfs:15.snapshot "${IMAGE_PATH}"/freebsd-zfs:15.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:15.snapshot

echo
echo "freebsd-zfs:runtime-15.snapshot"
podman tag localhost/freebsd-zfs:runtime-15.snapshot "${IMAGE_PATH}"/freebsd-zfs:runtime-15.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:15.snapshot"
podman tag localhost/freebsd-zfs:15.snapshot "${IMAGE_PATH}"/freebsd-zfs:15.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:15.snapshot

echo
echo "freebsd-zfs:runtime-15.snapshot"
podman tag localhost/freebsd-zfs:runtime-15.snapshot "${IMAGE_PATH}"/freebsd-zfs:runtime-15.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15.snapshot

