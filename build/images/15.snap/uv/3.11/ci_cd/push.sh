#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd15.snapshot"
podman tag localhost/uv:3-freebsd15.snapshot "${IMAGE_PATH}"/uv:3-freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:3-freebsd15.snapshot

echo
echo "uv:3.11-freebsd15.snapshot"
podman tag localhost/uv:3.11-freebsd15.snapshot "${IMAGE_PATH}"/uv:3.11-freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:3.11-freebsd15.snapshot

echo
echo "uv:freebsd15.snapshot"
podman tag localhost/uv:freebsd15.snapshot "${IMAGE_PATH}"/uv:freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:freebsd15.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd15.snapshot"
podman tag localhost/uv:3-freebsd15.snapshot "${IMAGE_PATH}"/uv:3-freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:3-freebsd15.snapshot

echo
echo "uv:3.11-freebsd15.snapshot"
podman tag localhost/uv:3.11-freebsd15.snapshot "${IMAGE_PATH}"/uv:3.11-freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:3.11-freebsd15.snapshot

echo
echo "uv:freebsd15.snapshot"
podman tag localhost/uv:freebsd15.snapshot "${IMAGE_PATH}"/uv:freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:freebsd15.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd15.snapshot"
podman tag localhost/uv:3-freebsd15.snapshot "${IMAGE_PATH}"/uv:3-freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:3-freebsd15.snapshot

echo
echo "uv:3.11-freebsd15.snapshot"
podman tag localhost/uv:3.11-freebsd15.snapshot "${IMAGE_PATH}"/uv:3.11-freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:3.11-freebsd15.snapshot

echo
echo "uv:freebsd15.snapshot"
podman tag localhost/uv:freebsd15.snapshot "${IMAGE_PATH}"/uv:freebsd15.snapshot
podman push "${IMAGE_PATH}"/uv:freebsd15.snapshot

