#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing postgres-13 to ${IMAGE_PATH}"

echo
echo "postgres:13-freebsd"
podman tag localhost/postgres:13-freebsd "${IMAGE_PATH}"/postgres:13-freebsd
podman push "${IMAGE_PATH}"/postgres:13-freebsd

echo
echo "postgres:13-freebsd14"
podman tag localhost/postgres:13-freebsd14 "${IMAGE_PATH}"/postgres:13-freebsd14
podman push "${IMAGE_PATH}"/postgres:13-freebsd14

echo
echo "postgres:13-freebsd14.3"
podman tag localhost/postgres:13-freebsd14.3 "${IMAGE_PATH}"/postgres:13-freebsd14.3
podman push "${IMAGE_PATH}"/postgres:13-freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing postgres-13 to ${IMAGE_PATH}"

echo
echo "postgres:13-freebsd"
podman tag localhost/postgres:13-freebsd "${IMAGE_PATH}"/postgres:13-freebsd
podman push "${IMAGE_PATH}"/postgres:13-freebsd

echo
echo "postgres:13-freebsd14"
podman tag localhost/postgres:13-freebsd14 "${IMAGE_PATH}"/postgres:13-freebsd14
podman push "${IMAGE_PATH}"/postgres:13-freebsd14

echo
echo "postgres:13-freebsd14.3"
podman tag localhost/postgres:13-freebsd14.3 "${IMAGE_PATH}"/postgres:13-freebsd14.3
podman push "${IMAGE_PATH}"/postgres:13-freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing postgres-13 to ${IMAGE_PATH}"

echo
echo "postgres:13-freebsd"
podman tag localhost/postgres:13-freebsd "${IMAGE_PATH}"/postgres:13-freebsd
podman push "${IMAGE_PATH}"/postgres:13-freebsd

echo
echo "postgres:13-freebsd14"
podman tag localhost/postgres:13-freebsd14 "${IMAGE_PATH}"/postgres:13-freebsd14
podman push "${IMAGE_PATH}"/postgres:13-freebsd14

echo
echo "postgres:13-freebsd14.3"
podman tag localhost/postgres:13-freebsd14.3 "${IMAGE_PATH}"/postgres:13-freebsd14.3
podman push "${IMAGE_PATH}"/postgres:13-freebsd14.3

