#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:16"
podman tag localhost/freebsd-zfs:16 "${IMAGE_PATH}"/freebsd-zfs:16
podman push "${IMAGE_PATH}"/freebsd-zfs:16

echo
echo "freebsd-zfs:16.snapshot"
podman tag localhost/freebsd-zfs:16.snapshot "${IMAGE_PATH}"/freebsd-zfs:16.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:16.snapshot

echo
echo "freebsd-zfs:runtime-16"
podman tag localhost/freebsd-zfs:runtime-16 "${IMAGE_PATH}"/freebsd-zfs:runtime-16
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-16

echo
echo "freebsd-zfs:runtime-16.snapshot"
podman tag localhost/freebsd-zfs:runtime-16.snapshot "${IMAGE_PATH}"/freebsd-zfs:runtime-16.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-16.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:16"
podman tag localhost/freebsd-zfs:16 "${IMAGE_PATH}"/freebsd-zfs:16
podman push "${IMAGE_PATH}"/freebsd-zfs:16

echo
echo "freebsd-zfs:16.snapshot"
podman tag localhost/freebsd-zfs:16.snapshot "${IMAGE_PATH}"/freebsd-zfs:16.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:16.snapshot

echo
echo "freebsd-zfs:runtime-16"
podman tag localhost/freebsd-zfs:runtime-16 "${IMAGE_PATH}"/freebsd-zfs:runtime-16
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-16

echo
echo "freebsd-zfs:runtime-16.snapshot"
podman tag localhost/freebsd-zfs:runtime-16.snapshot "${IMAGE_PATH}"/freebsd-zfs:runtime-16.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-16.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:16"
podman tag localhost/freebsd-zfs:16 "${IMAGE_PATH}"/freebsd-zfs:16
podman push "${IMAGE_PATH}"/freebsd-zfs:16

echo
echo "freebsd-zfs:16.snapshot"
podman tag localhost/freebsd-zfs:16.snapshot "${IMAGE_PATH}"/freebsd-zfs:16.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:16.snapshot

echo
echo "freebsd-zfs:runtime-16"
podman tag localhost/freebsd-zfs:runtime-16 "${IMAGE_PATH}"/freebsd-zfs:runtime-16
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-16

echo
echo "freebsd-zfs:runtime-16.snapshot"
podman tag localhost/freebsd-zfs:runtime-16.snapshot "${IMAGE_PATH}"/freebsd-zfs:runtime-16.snapshot
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-16.snapshot

