#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd16"
podman tag localhost/uv:3-freebsd16 "${IMAGE_PATH}"/uv:3-freebsd16
podman push "${IMAGE_PATH}"/uv:3-freebsd16

echo
echo "uv:3-freebsd16.snapshot"
podman tag localhost/uv:3-freebsd16.snapshot "${IMAGE_PATH}"/uv:3-freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:3-freebsd16.snapshot

echo
echo "uv:3.11-freebsd16"
podman tag localhost/uv:3.11-freebsd16 "${IMAGE_PATH}"/uv:3.11-freebsd16
podman push "${IMAGE_PATH}"/uv:3.11-freebsd16

echo
echo "uv:3.11-freebsd16.snapshot"
podman tag localhost/uv:3.11-freebsd16.snapshot "${IMAGE_PATH}"/uv:3.11-freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:3.11-freebsd16.snapshot

echo
echo "uv:freebsd16"
podman tag localhost/uv:freebsd16 "${IMAGE_PATH}"/uv:freebsd16
podman push "${IMAGE_PATH}"/uv:freebsd16

echo
echo "uv:freebsd16.snapshot"
podman tag localhost/uv:freebsd16.snapshot "${IMAGE_PATH}"/uv:freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:freebsd16.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd16"
podman tag localhost/uv:3-freebsd16 "${IMAGE_PATH}"/uv:3-freebsd16
podman push "${IMAGE_PATH}"/uv:3-freebsd16

echo
echo "uv:3-freebsd16.snapshot"
podman tag localhost/uv:3-freebsd16.snapshot "${IMAGE_PATH}"/uv:3-freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:3-freebsd16.snapshot

echo
echo "uv:3.11-freebsd16"
podman tag localhost/uv:3.11-freebsd16 "${IMAGE_PATH}"/uv:3.11-freebsd16
podman push "${IMAGE_PATH}"/uv:3.11-freebsd16

echo
echo "uv:3.11-freebsd16.snapshot"
podman tag localhost/uv:3.11-freebsd16.snapshot "${IMAGE_PATH}"/uv:3.11-freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:3.11-freebsd16.snapshot

echo
echo "uv:freebsd16"
podman tag localhost/uv:freebsd16 "${IMAGE_PATH}"/uv:freebsd16
podman push "${IMAGE_PATH}"/uv:freebsd16

echo
echo "uv:freebsd16.snapshot"
podman tag localhost/uv:freebsd16.snapshot "${IMAGE_PATH}"/uv:freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:freebsd16.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd16"
podman tag localhost/uv:3-freebsd16 "${IMAGE_PATH}"/uv:3-freebsd16
podman push "${IMAGE_PATH}"/uv:3-freebsd16

echo
echo "uv:3-freebsd16.snapshot"
podman tag localhost/uv:3-freebsd16.snapshot "${IMAGE_PATH}"/uv:3-freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:3-freebsd16.snapshot

echo
echo "uv:3.11-freebsd16"
podman tag localhost/uv:3.11-freebsd16 "${IMAGE_PATH}"/uv:3.11-freebsd16
podman push "${IMAGE_PATH}"/uv:3.11-freebsd16

echo
echo "uv:3.11-freebsd16.snapshot"
podman tag localhost/uv:3.11-freebsd16.snapshot "${IMAGE_PATH}"/uv:3.11-freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:3.11-freebsd16.snapshot

echo
echo "uv:freebsd16"
podman tag localhost/uv:freebsd16 "${IMAGE_PATH}"/uv:freebsd16
podman push "${IMAGE_PATH}"/uv:freebsd16

echo
echo "uv:freebsd16.snapshot"
podman tag localhost/uv:freebsd16.snapshot "${IMAGE_PATH}"/uv:freebsd16.snapshot
podman push "${IMAGE_PATH}"/uv:freebsd16.snapshot

