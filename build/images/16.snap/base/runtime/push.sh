#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base:16"
podman tag localhost/freebsd-base:16 "${IMAGE_PATH}"/freebsd-base:16
podman push "${IMAGE_PATH}"/freebsd-base:16

echo
echo "freebsd-base:16.snapshot"
podman tag localhost/freebsd-base:16.snapshot "${IMAGE_PATH}"/freebsd-base:16.snapshot
podman push "${IMAGE_PATH}"/freebsd-base:16.snapshot

echo
echo "freebsd-base:runtime-16"
podman tag localhost/freebsd-base:runtime-16 "${IMAGE_PATH}"/freebsd-base:runtime-16
podman push "${IMAGE_PATH}"/freebsd-base:runtime-16

echo
echo "freebsd-base:runtime-16.snapshot"
podman tag localhost/freebsd-base:runtime-16.snapshot "${IMAGE_PATH}"/freebsd-base:runtime-16.snapshot
podman push "${IMAGE_PATH}"/freebsd-base:runtime-16.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base:16"
podman tag localhost/freebsd-base:16 "${IMAGE_PATH}"/freebsd-base:16
podman push "${IMAGE_PATH}"/freebsd-base:16

echo
echo "freebsd-base:16.snapshot"
podman tag localhost/freebsd-base:16.snapshot "${IMAGE_PATH}"/freebsd-base:16.snapshot
podman push "${IMAGE_PATH}"/freebsd-base:16.snapshot

echo
echo "freebsd-base:runtime-16"
podman tag localhost/freebsd-base:runtime-16 "${IMAGE_PATH}"/freebsd-base:runtime-16
podman push "${IMAGE_PATH}"/freebsd-base:runtime-16

echo
echo "freebsd-base:runtime-16.snapshot"
podman tag localhost/freebsd-base:runtime-16.snapshot "${IMAGE_PATH}"/freebsd-base:runtime-16.snapshot
podman push "${IMAGE_PATH}"/freebsd-base:runtime-16.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing freebsd-base-runtime to ${IMAGE_PATH}"

echo
echo "freebsd-base:16"
podman tag localhost/freebsd-base:16 "${IMAGE_PATH}"/freebsd-base:16
podman push "${IMAGE_PATH}"/freebsd-base:16

echo
echo "freebsd-base:16.snapshot"
podman tag localhost/freebsd-base:16.snapshot "${IMAGE_PATH}"/freebsd-base:16.snapshot
podman push "${IMAGE_PATH}"/freebsd-base:16.snapshot

echo
echo "freebsd-base:runtime-16"
podman tag localhost/freebsd-base:runtime-16 "${IMAGE_PATH}"/freebsd-base:runtime-16
podman push "${IMAGE_PATH}"/freebsd-base:runtime-16

echo
echo "freebsd-base:runtime-16.snapshot"
podman tag localhost/freebsd-base:runtime-16.snapshot "${IMAGE_PATH}"/freebsd-base:runtime-16.snapshot
podman push "${IMAGE_PATH}"/freebsd-base:runtime-16.snapshot

