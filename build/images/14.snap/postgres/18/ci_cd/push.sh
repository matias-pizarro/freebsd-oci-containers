#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd14.snapshot"
podman tag localhost/postgres:18-freebsd14.snapshot "${IMAGE_PATH}"/postgres:18-freebsd14.snapshot
podman push "${IMAGE_PATH}"/postgres:18-freebsd14.snapshot

echo
echo "postgres:freebsd14.snapshot"
podman tag localhost/postgres:freebsd14.snapshot "${IMAGE_PATH}"/postgres:freebsd14.snapshot
podman push "${IMAGE_PATH}"/postgres:freebsd14.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd14.snapshot"
podman tag localhost/postgres:18-freebsd14.snapshot "${IMAGE_PATH}"/postgres:18-freebsd14.snapshot
podman push "${IMAGE_PATH}"/postgres:18-freebsd14.snapshot

echo
echo "postgres:freebsd14.snapshot"
podman tag localhost/postgres:freebsd14.snapshot "${IMAGE_PATH}"/postgres:freebsd14.snapshot
podman push "${IMAGE_PATH}"/postgres:freebsd14.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing postgres-18 to ${IMAGE_PATH}"

echo
echo "postgres:18-freebsd14.snapshot"
podman tag localhost/postgres:18-freebsd14.snapshot "${IMAGE_PATH}"/postgres:18-freebsd14.snapshot
podman push "${IMAGE_PATH}"/postgres:18-freebsd14.snapshot

echo
echo "postgres:freebsd14.snapshot"
podman tag localhost/postgres:freebsd14.snapshot "${IMAGE_PATH}"/postgres:freebsd14.snapshot
podman push "${IMAGE_PATH}"/postgres:freebsd14.snapshot

