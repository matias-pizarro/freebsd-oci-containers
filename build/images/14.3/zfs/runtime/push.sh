#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs"
podman tag localhost/freebsd-zfs "${IMAGE_PATH}"/freebsd-zfs
podman push "${IMAGE_PATH}"/freebsd-zfs

echo
echo "freebsd-zfs:14"
podman tag localhost/freebsd-zfs:14 "${IMAGE_PATH}"/freebsd-zfs:14
podman push "${IMAGE_PATH}"/freebsd-zfs:14

echo
echo "freebsd-zfs:14.3"
podman tag localhost/freebsd-zfs:14.3 "${IMAGE_PATH}"/freebsd-zfs:14.3
podman push "${IMAGE_PATH}"/freebsd-zfs:14.3

echo
echo "freebsd-zfs:runtime"
podman tag localhost/freebsd-zfs:runtime "${IMAGE_PATH}"/freebsd-zfs:runtime
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime

echo
echo "freebsd-zfs:runtime-14"
podman tag localhost/freebsd-zfs:runtime-14 "${IMAGE_PATH}"/freebsd-zfs:runtime-14
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-14

echo
echo "freebsd-zfs:runtime-14.3"
podman tag localhost/freebsd-zfs:runtime-14.3 "${IMAGE_PATH}"/freebsd-zfs:runtime-14.3
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs"
podman tag localhost/freebsd-zfs "${IMAGE_PATH}"/freebsd-zfs
podman push "${IMAGE_PATH}"/freebsd-zfs

echo
echo "freebsd-zfs:14"
podman tag localhost/freebsd-zfs:14 "${IMAGE_PATH}"/freebsd-zfs:14
podman push "${IMAGE_PATH}"/freebsd-zfs:14

echo
echo "freebsd-zfs:14.3"
podman tag localhost/freebsd-zfs:14.3 "${IMAGE_PATH}"/freebsd-zfs:14.3
podman push "${IMAGE_PATH}"/freebsd-zfs:14.3

echo
echo "freebsd-zfs:runtime"
podman tag localhost/freebsd-zfs:runtime "${IMAGE_PATH}"/freebsd-zfs:runtime
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime

echo
echo "freebsd-zfs:runtime-14"
podman tag localhost/freebsd-zfs:runtime-14 "${IMAGE_PATH}"/freebsd-zfs:runtime-14
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-14

echo
echo "freebsd-zfs:runtime-14.3"
podman tag localhost/freebsd-zfs:runtime-14.3 "${IMAGE_PATH}"/freebsd-zfs:runtime-14.3
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-zfs-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-zfs"
podman tag localhost/freebsd-zfs "${IMAGE_PATH}"/freebsd-zfs
podman push "${IMAGE_PATH}"/freebsd-zfs

echo
echo "freebsd-zfs:14"
podman tag localhost/freebsd-zfs:14 "${IMAGE_PATH}"/freebsd-zfs:14
podman push "${IMAGE_PATH}"/freebsd-zfs:14

echo
echo "freebsd-zfs:14.3"
podman tag localhost/freebsd-zfs:14.3 "${IMAGE_PATH}"/freebsd-zfs:14.3
podman push "${IMAGE_PATH}"/freebsd-zfs:14.3

echo
echo "freebsd-zfs:runtime"
podman tag localhost/freebsd-zfs:runtime "${IMAGE_PATH}"/freebsd-zfs:runtime
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime

echo
echo "freebsd-zfs:runtime-14"
podman tag localhost/freebsd-zfs:runtime-14 "${IMAGE_PATH}"/freebsd-zfs:runtime-14
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-14

echo
echo "freebsd-zfs:runtime-14.3"
podman tag localhost/freebsd-zfs:runtime-14.3 "${IMAGE_PATH}"/freebsd-zfs:runtime-14.3
podman push "${IMAGE_PATH}"/freebsd-zfs:runtime-14.3

