#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing node-24 to ${IMAGE_PATH}"

echo
echo "node:24-freebsd"
podman tag localhost/node:24-freebsd "${IMAGE_PATH}"/node:24-freebsd
podman push "${IMAGE_PATH}"/node:24-freebsd

echo
echo "node:24-freebsd14"
podman tag localhost/node:24-freebsd14 "${IMAGE_PATH}"/node:24-freebsd14
podman push "${IMAGE_PATH}"/node:24-freebsd14

echo
echo "node:24-freebsd14.3"
podman tag localhost/node:24-freebsd14.3 "${IMAGE_PATH}"/node:24-freebsd14.3
podman push "${IMAGE_PATH}"/node:24-freebsd14.3

echo
echo "node:freebsd"
podman tag localhost/node:freebsd "${IMAGE_PATH}"/node:freebsd
podman push "${IMAGE_PATH}"/node:freebsd

echo
echo "node:freebsd14"
podman tag localhost/node:freebsd14 "${IMAGE_PATH}"/node:freebsd14
podman push "${IMAGE_PATH}"/node:freebsd14

echo
echo "node:freebsd14.3"
podman tag localhost/node:freebsd14.3 "${IMAGE_PATH}"/node:freebsd14.3
podman push "${IMAGE_PATH}"/node:freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing node-24 to ${IMAGE_PATH}"

echo
echo "node:24-freebsd"
podman tag localhost/node:24-freebsd "${IMAGE_PATH}"/node:24-freebsd
podman push "${IMAGE_PATH}"/node:24-freebsd

echo
echo "node:24-freebsd14"
podman tag localhost/node:24-freebsd14 "${IMAGE_PATH}"/node:24-freebsd14
podman push "${IMAGE_PATH}"/node:24-freebsd14

echo
echo "node:24-freebsd14.3"
podman tag localhost/node:24-freebsd14.3 "${IMAGE_PATH}"/node:24-freebsd14.3
podman push "${IMAGE_PATH}"/node:24-freebsd14.3

echo
echo "node:freebsd"
podman tag localhost/node:freebsd "${IMAGE_PATH}"/node:freebsd
podman push "${IMAGE_PATH}"/node:freebsd

echo
echo "node:freebsd14"
podman tag localhost/node:freebsd14 "${IMAGE_PATH}"/node:freebsd14
podman push "${IMAGE_PATH}"/node:freebsd14

echo
echo "node:freebsd14.3"
podman tag localhost/node:freebsd14.3 "${IMAGE_PATH}"/node:freebsd14.3
podman push "${IMAGE_PATH}"/node:freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing node-24 to ${IMAGE_PATH}"

echo
echo "node:24-freebsd"
podman tag localhost/node:24-freebsd "${IMAGE_PATH}"/node:24-freebsd
podman push "${IMAGE_PATH}"/node:24-freebsd

echo
echo "node:24-freebsd14"
podman tag localhost/node:24-freebsd14 "${IMAGE_PATH}"/node:24-freebsd14
podman push "${IMAGE_PATH}"/node:24-freebsd14

echo
echo "node:24-freebsd14.3"
podman tag localhost/node:24-freebsd14.3 "${IMAGE_PATH}"/node:24-freebsd14.3
podman push "${IMAGE_PATH}"/node:24-freebsd14.3

echo
echo "node:freebsd"
podman tag localhost/node:freebsd "${IMAGE_PATH}"/node:freebsd
podman push "${IMAGE_PATH}"/node:freebsd

echo
echo "node:freebsd14"
podman tag localhost/node:freebsd14 "${IMAGE_PATH}"/node:freebsd14
podman push "${IMAGE_PATH}"/node:freebsd14

echo
echo "node:freebsd14.3"
podman tag localhost/node:freebsd14.3 "${IMAGE_PATH}"/node:freebsd14.3
podman push "${IMAGE_PATH}"/node:freebsd14.3

