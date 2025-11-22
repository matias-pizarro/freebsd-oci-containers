#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd15"
podman tag localhost/postgres:18-freebsd15 "${IMAGE_PATH}"/postgres:18-freebsd15
podman push "${IMAGE_PATH}"/postgres:18-freebsd15

echo
echo "postgres:18-freebsd15.0"
podman tag localhost/postgres:18-freebsd15.0 "${IMAGE_PATH}"/postgres:18-freebsd15.0
podman push "${IMAGE_PATH}"/postgres:18-freebsd15.0

echo
echo "postgres:freebsd15"
podman tag localhost/postgres:freebsd15 "${IMAGE_PATH}"/postgres:freebsd15
podman push "${IMAGE_PATH}"/postgres:freebsd15

echo
echo "postgres:freebsd15.0"
podman tag localhost/postgres:freebsd15.0 "${IMAGE_PATH}"/postgres:freebsd15.0
podman push "${IMAGE_PATH}"/postgres:freebsd15.0


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd15"
podman tag localhost/postgres:18-freebsd15 "${IMAGE_PATH}"/postgres:18-freebsd15
podman push "${IMAGE_PATH}"/postgres:18-freebsd15

echo
echo "postgres:18-freebsd15.0"
podman tag localhost/postgres:18-freebsd15.0 "${IMAGE_PATH}"/postgres:18-freebsd15.0
podman push "${IMAGE_PATH}"/postgres:18-freebsd15.0

echo
echo "postgres:freebsd15"
podman tag localhost/postgres:freebsd15 "${IMAGE_PATH}"/postgres:freebsd15
podman push "${IMAGE_PATH}"/postgres:freebsd15

echo
echo "postgres:freebsd15.0"
podman tag localhost/postgres:freebsd15.0 "${IMAGE_PATH}"/postgres:freebsd15.0
podman push "${IMAGE_PATH}"/postgres:freebsd15.0


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd15"
podman tag localhost/postgres:18-freebsd15 "${IMAGE_PATH}"/postgres:18-freebsd15
podman push "${IMAGE_PATH}"/postgres:18-freebsd15

echo
echo "postgres:18-freebsd15.0"
podman tag localhost/postgres:18-freebsd15.0 "${IMAGE_PATH}"/postgres:18-freebsd15.0
podman push "${IMAGE_PATH}"/postgres:18-freebsd15.0

echo
echo "postgres:freebsd15"
podman tag localhost/postgres:freebsd15 "${IMAGE_PATH}"/postgres:freebsd15
podman push "${IMAGE_PATH}"/postgres:freebsd15

echo
echo "postgres:freebsd15.0"
podman tag localhost/postgres:freebsd15.0 "${IMAGE_PATH}"/postgres:freebsd15.0
podman push "${IMAGE_PATH}"/postgres:freebsd15.0

