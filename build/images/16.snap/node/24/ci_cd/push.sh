#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing node-24 to ${IMAGE_PATH}"

echo
echo "node:24-freebsd16"
podman tag localhost/node:24-freebsd16 "${IMAGE_PATH}"/node:24-freebsd16
podman push "${IMAGE_PATH}"/node:24-freebsd16

echo
echo "node:24-freebsd16.snapshot"
podman tag localhost/node:24-freebsd16.snapshot "${IMAGE_PATH}"/node:24-freebsd16.snapshot
podman push "${IMAGE_PATH}"/node:24-freebsd16.snapshot

echo
echo "node:freebsd16"
podman tag localhost/node:freebsd16 "${IMAGE_PATH}"/node:freebsd16
podman push "${IMAGE_PATH}"/node:freebsd16

echo
echo "node:freebsd16.snapshot"
podman tag localhost/node:freebsd16.snapshot "${IMAGE_PATH}"/node:freebsd16.snapshot
podman push "${IMAGE_PATH}"/node:freebsd16.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing node-24 to ${IMAGE_PATH}"

echo
echo "node:24-freebsd16"
podman tag localhost/node:24-freebsd16 "${IMAGE_PATH}"/node:24-freebsd16
podman push "${IMAGE_PATH}"/node:24-freebsd16

echo
echo "node:24-freebsd16.snapshot"
podman tag localhost/node:24-freebsd16.snapshot "${IMAGE_PATH}"/node:24-freebsd16.snapshot
podman push "${IMAGE_PATH}"/node:24-freebsd16.snapshot

echo
echo "node:freebsd16"
podman tag localhost/node:freebsd16 "${IMAGE_PATH}"/node:freebsd16
podman push "${IMAGE_PATH}"/node:freebsd16

echo
echo "node:freebsd16.snapshot"
podman tag localhost/node:freebsd16.snapshot "${IMAGE_PATH}"/node:freebsd16.snapshot
podman push "${IMAGE_PATH}"/node:freebsd16.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing node-24 to ${IMAGE_PATH}"

echo
echo "node:24-freebsd16"
podman tag localhost/node:24-freebsd16 "${IMAGE_PATH}"/node:24-freebsd16
podman push "${IMAGE_PATH}"/node:24-freebsd16

echo
echo "node:24-freebsd16.snapshot"
podman tag localhost/node:24-freebsd16.snapshot "${IMAGE_PATH}"/node:24-freebsd16.snapshot
podman push "${IMAGE_PATH}"/node:24-freebsd16.snapshot

echo
echo "node:freebsd16"
podman tag localhost/node:freebsd16 "${IMAGE_PATH}"/node:freebsd16
podman push "${IMAGE_PATH}"/node:freebsd16

echo
echo "node:freebsd16.snapshot"
podman tag localhost/node:freebsd16.snapshot "${IMAGE_PATH}"/node:freebsd16.snapshot
podman push "${IMAGE_PATH}"/node:freebsd16.snapshot

