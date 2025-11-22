#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:15"
podman tag localhost/freebsd-zfs:15 "${IMAGE_PATH}"/freebsd-zfs:15
podman push "${IMAGE_PATH}"/freebsd-zfs:15

echo
echo "freebsd-zfs:15.0"
podman tag localhost/freebsd-zfs:15.0 "${IMAGE_PATH}"/freebsd-zfs:15.0
podman push "${IMAGE_PATH}"/freebsd-zfs:15.0

echo
echo "freebsd-zfs:runtime-15"
podman tag localhost/freebsd-zfs:runtime-15 "${IMAGE_PATH}"/freebsd-zfs:runtime-15
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15

echo
echo "freebsd-zfs:runtime-15.0"
podman tag localhost/freebsd-zfs:runtime-15.0 "${IMAGE_PATH}"/freebsd-zfs:runtime-15.0
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15.0


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:15"
podman tag localhost/freebsd-zfs:15 "${IMAGE_PATH}"/freebsd-zfs:15
podman push "${IMAGE_PATH}"/freebsd-zfs:15

echo
echo "freebsd-zfs:15.0"
podman tag localhost/freebsd-zfs:15.0 "${IMAGE_PATH}"/freebsd-zfs:15.0
podman push "${IMAGE_PATH}"/freebsd-zfs:15.0

echo
echo "freebsd-zfs:runtime-15"
podman tag localhost/freebsd-zfs:runtime-15 "${IMAGE_PATH}"/freebsd-zfs:runtime-15
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15

echo
echo "freebsd-zfs:runtime-15.0"
podman tag localhost/freebsd-zfs:runtime-15.0 "${IMAGE_PATH}"/freebsd-zfs:runtime-15.0
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15.0


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs:15"
podman tag localhost/freebsd-zfs:15 "${IMAGE_PATH}"/freebsd-zfs:15
podman push "${IMAGE_PATH}"/freebsd-zfs:15

echo
echo "freebsd-zfs:15.0"
podman tag localhost/freebsd-zfs:15.0 "${IMAGE_PATH}"/freebsd-zfs:15.0
podman push "${IMAGE_PATH}"/freebsd-zfs:15.0

echo
echo "freebsd-zfs:runtime-15"
podman tag localhost/freebsd-zfs:runtime-15 "${IMAGE_PATH}"/freebsd-zfs:runtime-15
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15

echo
echo "freebsd-zfs:runtime-15.0"
podman tag localhost/freebsd-zfs:runtime-15.0 "${IMAGE_PATH}"/freebsd-zfs:runtime-15.0
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-15.0

