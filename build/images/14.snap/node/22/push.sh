#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing node-22 to ${IMAGE_PATH}"

echo
echo "node:22-freebsd14.snapshot"
podman tag localhost/node:22-freebsd14.snapshot "${IMAGE_PATH}"/node:22-freebsd14.snapshot
podman push "${IMAGE_PATH}"/node:22-freebsd14.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing node-22 to ${IMAGE_PATH}"

echo
echo "node:22-freebsd14.snapshot"
podman tag localhost/node:22-freebsd14.snapshot "${IMAGE_PATH}"/node:22-freebsd14.snapshot
podman push "${IMAGE_PATH}"/node:22-freebsd14.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing node-22 to ${IMAGE_PATH}"

echo
echo "node:22-freebsd14.snapshot"
podman tag localhost/node:22-freebsd14.snapshot "${IMAGE_PATH}"/node:22-freebsd14.snapshot
podman push "${IMAGE_PATH}"/node:22-freebsd14.snapshot

