#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base:15"
podman tag localhost/freebsd-base:15 "${IMAGE_PATH}"/freebsd-base:15
podman push "${IMAGE_PATH}"/freebsd-base:15

echo
echo "freebsd-base:15.0"
podman tag localhost/freebsd-base:15.0 "${IMAGE_PATH}"/freebsd-base:15.0
podman push "${IMAGE_PATH}"/freebsd-base:15.0

echo
echo "freebsd-base:runtime-15"
podman tag localhost/freebsd-base:runtime-15 "${IMAGE_PATH}"/freebsd-base:runtime-15
podman push "${IMAGE_PATH}"/freebsd-base:runtime-15

echo
echo "freebsd-base:runtime-15.0"
podman tag localhost/freebsd-base:runtime-15.0 "${IMAGE_PATH}"/freebsd-base:runtime-15.0
podman push "${IMAGE_PATH}"/freebsd-base:runtime-15.0


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base:15"
podman tag localhost/freebsd-base:15 "${IMAGE_PATH}"/freebsd-base:15
podman push "${IMAGE_PATH}"/freebsd-base:15

echo
echo "freebsd-base:15.0"
podman tag localhost/freebsd-base:15.0 "${IMAGE_PATH}"/freebsd-base:15.0
podman push "${IMAGE_PATH}"/freebsd-base:15.0

echo
echo "freebsd-base:runtime-15"
podman tag localhost/freebsd-base:runtime-15 "${IMAGE_PATH}"/freebsd-base:runtime-15
podman push "${IMAGE_PATH}"/freebsd-base:runtime-15

echo
echo "freebsd-base:runtime-15.0"
podman tag localhost/freebsd-base:runtime-15.0 "${IMAGE_PATH}"/freebsd-base:runtime-15.0
podman push "${IMAGE_PATH}"/freebsd-base:runtime-15.0


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base:15"
podman tag localhost/freebsd-base:15 "${IMAGE_PATH}"/freebsd-base:15
podman push "${IMAGE_PATH}"/freebsd-base:15

echo
echo "freebsd-base:15.0"
podman tag localhost/freebsd-base:15.0 "${IMAGE_PATH}"/freebsd-base:15.0
podman push "${IMAGE_PATH}"/freebsd-base:15.0

echo
echo "freebsd-base:runtime-15"
podman tag localhost/freebsd-base:runtime-15 "${IMAGE_PATH}"/freebsd-base:runtime-15
podman push "${IMAGE_PATH}"/freebsd-base:runtime-15

echo
echo "freebsd-base:runtime-15.0"
podman tag localhost/freebsd-base:runtime-15.0 "${IMAGE_PATH}"/freebsd-base:runtime-15.0
podman push "${IMAGE_PATH}"/freebsd-base:runtime-15.0

