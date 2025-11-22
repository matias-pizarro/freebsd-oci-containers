#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base"
podman tag localhost/freebsd-base "${IMAGE_PATH}"/freebsd-base
podman push "${IMAGE_PATH}"/freebsd-base

echo
echo "freebsd-base:14"
podman tag localhost/freebsd-base:14 "${IMAGE_PATH}"/freebsd-base:14
podman push "${IMAGE_PATH}"/freebsd-base:14

echo
echo "freebsd-base:14.3"
podman tag localhost/freebsd-base:14.3 "${IMAGE_PATH}"/freebsd-base:14.3
podman push "${IMAGE_PATH}"/freebsd-base:14.3

echo
echo "freebsd-base:runtime"
podman tag localhost/freebsd-base:runtime "${IMAGE_PATH}"/freebsd-base:runtime
podman push "${IMAGE_PATH}"/freebsd-base:runtime

echo
echo "freebsd-base:runtime-14"
podman tag localhost/freebsd-base:runtime-14 "${IMAGE_PATH}"/freebsd-base:runtime-14
podman push "${IMAGE_PATH}"/freebsd-base:runtime-14

echo
echo "freebsd-base:runtime-14.3"
podman tag localhost/freebsd-base:runtime-14.3 "${IMAGE_PATH}"/freebsd-base:runtime-14.3
podman push "${IMAGE_PATH}"/freebsd-base:runtime-14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base"
podman tag localhost/freebsd-base "${IMAGE_PATH}"/freebsd-base
podman push "${IMAGE_PATH}"/freebsd-base

echo
echo "freebsd-base:14"
podman tag localhost/freebsd-base:14 "${IMAGE_PATH}"/freebsd-base:14
podman push "${IMAGE_PATH}"/freebsd-base:14

echo
echo "freebsd-base:14.3"
podman tag localhost/freebsd-base:14.3 "${IMAGE_PATH}"/freebsd-base:14.3
podman push "${IMAGE_PATH}"/freebsd-base:14.3

echo
echo "freebsd-base:runtime"
podman tag localhost/freebsd-base:runtime "${IMAGE_PATH}"/freebsd-base:runtime
podman push "${IMAGE_PATH}"/freebsd-base:runtime

echo
echo "freebsd-base:runtime-14"
podman tag localhost/freebsd-base:runtime-14 "${IMAGE_PATH}"/freebsd-base:runtime-14
podman push "${IMAGE_PATH}"/freebsd-base:runtime-14

echo
echo "freebsd-base:runtime-14.3"
podman tag localhost/freebsd-base:runtime-14.3 "${IMAGE_PATH}"/freebsd-base:runtime-14.3
podman push "${IMAGE_PATH}"/freebsd-base:runtime-14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base"
podman tag localhost/freebsd-base "${IMAGE_PATH}"/freebsd-base
podman push "${IMAGE_PATH}"/freebsd-base

echo
echo "freebsd-base:14"
podman tag localhost/freebsd-base:14 "${IMAGE_PATH}"/freebsd-base:14
podman push "${IMAGE_PATH}"/freebsd-base:14

echo
echo "freebsd-base:14.3"
podman tag localhost/freebsd-base:14.3 "${IMAGE_PATH}"/freebsd-base:14.3
podman push "${IMAGE_PATH}"/freebsd-base:14.3

echo
echo "freebsd-base:runtime"
podman tag localhost/freebsd-base:runtime "${IMAGE_PATH}"/freebsd-base:runtime
podman push "${IMAGE_PATH}"/freebsd-base:runtime

echo
echo "freebsd-base:runtime-14"
podman tag localhost/freebsd-base:runtime-14 "${IMAGE_PATH}"/freebsd-base:runtime-14
podman push "${IMAGE_PATH}"/freebsd-base:runtime-14

echo
echo "freebsd-base:runtime-14.3"
podman tag localhost/freebsd-base:runtime-14.3 "${IMAGE_PATH}"/freebsd-base:runtime-14.3
podman push "${IMAGE_PATH}"/freebsd-base:runtime-14.3

