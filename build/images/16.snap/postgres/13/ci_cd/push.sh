#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing postgres-13 to ${IMAGE_PATH}"

echo
echo "postgres:13-freebsd16"
podman tag localhost/postgres:13-freebsd16 "${IMAGE_PATH}"/postgres:13-freebsd16
podman push "${IMAGE_PATH}"/postgres:13-freebsd16

echo
echo "postgres:13-freebsd16.snapshot"
podman tag localhost/postgres:13-freebsd16.snapshot "${IMAGE_PATH}"/postgres:13-freebsd16.snapshot
podman push "${IMAGE_PATH}"/postgres:13-freebsd16.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing postgres-13 to ${IMAGE_PATH}"

echo
echo "postgres:13-freebsd16"
podman tag localhost/postgres:13-freebsd16 "${IMAGE_PATH}"/postgres:13-freebsd16
podman push "${IMAGE_PATH}"/postgres:13-freebsd16

echo
echo "postgres:13-freebsd16.snapshot"
podman tag localhost/postgres:13-freebsd16.snapshot "${IMAGE_PATH}"/postgres:13-freebsd16.snapshot
podman push "${IMAGE_PATH}"/postgres:13-freebsd16.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing postgres-13 to ${IMAGE_PATH}"

echo
echo "postgres:13-freebsd16"
podman tag localhost/postgres:13-freebsd16 "${IMAGE_PATH}"/postgres:13-freebsd16
podman push "${IMAGE_PATH}"/postgres:13-freebsd16

echo
echo "postgres:13-freebsd16.snapshot"
podman tag localhost/postgres:13-freebsd16.snapshot "${IMAGE_PATH}"/postgres:13-freebsd16.snapshot
podman push "${IMAGE_PATH}"/postgres:13-freebsd16.snapshot

