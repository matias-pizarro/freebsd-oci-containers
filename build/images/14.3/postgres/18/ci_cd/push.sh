#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd"
podman tag localhost/postgres:18-freebsd "${IMAGE_PATH}"/postgres:18-freebsd
podman push "${IMAGE_PATH}"/postgres:18-freebsd

echo
echo "postgres:18-freebsd14"
podman tag localhost/postgres:18-freebsd14 "${IMAGE_PATH}"/postgres:18-freebsd14
podman push "${IMAGE_PATH}"/postgres:18-freebsd14

echo
echo "postgres:18-freebsd14.3"
podman tag localhost/postgres:18-freebsd14.3 "${IMAGE_PATH}"/postgres:18-freebsd14.3
podman push "${IMAGE_PATH}"/postgres:18-freebsd14.3

echo
echo "postgres:freebsd"
podman tag localhost/postgres:freebsd "${IMAGE_PATH}"/postgres:freebsd
podman push "${IMAGE_PATH}"/postgres:freebsd

echo
echo "postgres:freebsd14"
podman tag localhost/postgres:freebsd14 "${IMAGE_PATH}"/postgres:freebsd14
podman push "${IMAGE_PATH}"/postgres:freebsd14

echo
echo "postgres:freebsd14.3"
podman tag localhost/postgres:freebsd14.3 "${IMAGE_PATH}"/postgres:freebsd14.3
podman push "${IMAGE_PATH}"/postgres:freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd"
podman tag localhost/postgres:18-freebsd "${IMAGE_PATH}"/postgres:18-freebsd
podman push "${IMAGE_PATH}"/postgres:18-freebsd

echo
echo "postgres:18-freebsd14"
podman tag localhost/postgres:18-freebsd14 "${IMAGE_PATH}"/postgres:18-freebsd14
podman push "${IMAGE_PATH}"/postgres:18-freebsd14

echo
echo "postgres:18-freebsd14.3"
podman tag localhost/postgres:18-freebsd14.3 "${IMAGE_PATH}"/postgres:18-freebsd14.3
podman push "${IMAGE_PATH}"/postgres:18-freebsd14.3

echo
echo "postgres:freebsd"
podman tag localhost/postgres:freebsd "${IMAGE_PATH}"/postgres:freebsd
podman push "${IMAGE_PATH}"/postgres:freebsd

echo
echo "postgres:freebsd14"
podman tag localhost/postgres:freebsd14 "${IMAGE_PATH}"/postgres:freebsd14
podman push "${IMAGE_PATH}"/postgres:freebsd14

echo
echo "postgres:freebsd14.3"
podman tag localhost/postgres:freebsd14.3 "${IMAGE_PATH}"/postgres:freebsd14.3
podman push "${IMAGE_PATH}"/postgres:freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd"
podman tag localhost/postgres:18-freebsd "${IMAGE_PATH}"/postgres:18-freebsd
podman push "${IMAGE_PATH}"/postgres:18-freebsd

echo
echo "postgres:18-freebsd14"
podman tag localhost/postgres:18-freebsd14 "${IMAGE_PATH}"/postgres:18-freebsd14
podman push "${IMAGE_PATH}"/postgres:18-freebsd14

echo
echo "postgres:18-freebsd14.3"
podman tag localhost/postgres:18-freebsd14.3 "${IMAGE_PATH}"/postgres:18-freebsd14.3
podman push "${IMAGE_PATH}"/postgres:18-freebsd14.3

echo
echo "postgres:freebsd"
podman tag localhost/postgres:freebsd "${IMAGE_PATH}"/postgres:freebsd
podman push "${IMAGE_PATH}"/postgres:freebsd

echo
echo "postgres:freebsd14"
podman tag localhost/postgres:freebsd14 "${IMAGE_PATH}"/postgres:freebsd14
podman push "${IMAGE_PATH}"/postgres:freebsd14

echo
echo "postgres:freebsd14.3"
podman tag localhost/postgres:freebsd14.3 "${IMAGE_PATH}"/postgres:freebsd14.3
podman push "${IMAGE_PATH}"/postgres:freebsd14.3

