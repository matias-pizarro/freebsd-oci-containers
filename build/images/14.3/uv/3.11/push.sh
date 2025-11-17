#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd"
podman tag localhost/uv:3-freebsd "${IMAGE_PATH}"/uv:3-freebsd
podman push "${IMAGE_PATH}"/uv:3-freebsd

echo
echo "uv:3-freebsd14"
podman tag localhost/uv:3-freebsd14 "${IMAGE_PATH}"/uv:3-freebsd14
podman push "${IMAGE_PATH}"/uv:3-freebsd14

echo
echo "uv:3-freebsd14.3"
podman tag localhost/uv:3-freebsd14.3 "${IMAGE_PATH}"/uv:3-freebsd14.3
podman push "${IMAGE_PATH}"/uv:3-freebsd14.3

echo
echo "uv:3.11-freebsd"
podman tag localhost/uv:3.11-freebsd "${IMAGE_PATH}"/uv:3.11-freebsd
podman push "${IMAGE_PATH}"/uv:3.11-freebsd

echo
echo "uv:3.11-freebsd14"
podman tag localhost/uv:3.11-freebsd14 "${IMAGE_PATH}"/uv:3.11-freebsd14
podman push "${IMAGE_PATH}"/uv:3.11-freebsd14

echo
echo "uv:3.11-freebsd14.3"
podman tag localhost/uv:3.11-freebsd14.3 "${IMAGE_PATH}"/uv:3.11-freebsd14.3
podman push "${IMAGE_PATH}"/uv:3.11-freebsd14.3

echo
echo "uv:freebsd"
podman tag localhost/uv:freebsd "${IMAGE_PATH}"/uv:freebsd
podman push "${IMAGE_PATH}"/uv:freebsd

echo
echo "uv:freebsd14"
podman tag localhost/uv:freebsd14 "${IMAGE_PATH}"/uv:freebsd14
podman push "${IMAGE_PATH}"/uv:freebsd14

echo
echo "uv:freebsd14.3"
podman tag localhost/uv:freebsd14.3 "${IMAGE_PATH}"/uv:freebsd14.3
podman push "${IMAGE_PATH}"/uv:freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd"
podman tag localhost/uv:3-freebsd "${IMAGE_PATH}"/uv:3-freebsd
podman push "${IMAGE_PATH}"/uv:3-freebsd

echo
echo "uv:3-freebsd14"
podman tag localhost/uv:3-freebsd14 "${IMAGE_PATH}"/uv:3-freebsd14
podman push "${IMAGE_PATH}"/uv:3-freebsd14

echo
echo "uv:3-freebsd14.3"
podman tag localhost/uv:3-freebsd14.3 "${IMAGE_PATH}"/uv:3-freebsd14.3
podman push "${IMAGE_PATH}"/uv:3-freebsd14.3

echo
echo "uv:3.11-freebsd"
podman tag localhost/uv:3.11-freebsd "${IMAGE_PATH}"/uv:3.11-freebsd
podman push "${IMAGE_PATH}"/uv:3.11-freebsd

echo
echo "uv:3.11-freebsd14"
podman tag localhost/uv:3.11-freebsd14 "${IMAGE_PATH}"/uv:3.11-freebsd14
podman push "${IMAGE_PATH}"/uv:3.11-freebsd14

echo
echo "uv:3.11-freebsd14.3"
podman tag localhost/uv:3.11-freebsd14.3 "${IMAGE_PATH}"/uv:3.11-freebsd14.3
podman push "${IMAGE_PATH}"/uv:3.11-freebsd14.3

echo
echo "uv:freebsd"
podman tag localhost/uv:freebsd "${IMAGE_PATH}"/uv:freebsd
podman push "${IMAGE_PATH}"/uv:freebsd

echo
echo "uv:freebsd14"
podman tag localhost/uv:freebsd14 "${IMAGE_PATH}"/uv:freebsd14
podman push "${IMAGE_PATH}"/uv:freebsd14

echo
echo "uv:freebsd14.3"
podman tag localhost/uv:freebsd14.3 "${IMAGE_PATH}"/uv:freebsd14.3
podman push "${IMAGE_PATH}"/uv:freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing uv-3.11 to ${IMAGE_PATH}"

echo
echo "uv:3-freebsd"
podman tag localhost/uv:3-freebsd "${IMAGE_PATH}"/uv:3-freebsd
podman push "${IMAGE_PATH}"/uv:3-freebsd

echo
echo "uv:3-freebsd14"
podman tag localhost/uv:3-freebsd14 "${IMAGE_PATH}"/uv:3-freebsd14
podman push "${IMAGE_PATH}"/uv:3-freebsd14

echo
echo "uv:3-freebsd14.3"
podman tag localhost/uv:3-freebsd14.3 "${IMAGE_PATH}"/uv:3-freebsd14.3
podman push "${IMAGE_PATH}"/uv:3-freebsd14.3

echo
echo "uv:3.11-freebsd"
podman tag localhost/uv:3.11-freebsd "${IMAGE_PATH}"/uv:3.11-freebsd
podman push "${IMAGE_PATH}"/uv:3.11-freebsd

echo
echo "uv:3.11-freebsd14"
podman tag localhost/uv:3.11-freebsd14 "${IMAGE_PATH}"/uv:3.11-freebsd14
podman push "${IMAGE_PATH}"/uv:3.11-freebsd14

echo
echo "uv:3.11-freebsd14.3"
podman tag localhost/uv:3.11-freebsd14.3 "${IMAGE_PATH}"/uv:3.11-freebsd14.3
podman push "${IMAGE_PATH}"/uv:3.11-freebsd14.3

echo
echo "uv:freebsd"
podman tag localhost/uv:freebsd "${IMAGE_PATH}"/uv:freebsd
podman push "${IMAGE_PATH}"/uv:freebsd

echo
echo "uv:freebsd14"
podman tag localhost/uv:freebsd14 "${IMAGE_PATH}"/uv:freebsd14
podman push "${IMAGE_PATH}"/uv:freebsd14

echo
echo "uv:freebsd14.3"
podman tag localhost/uv:freebsd14.3 "${IMAGE_PATH}"/uv:freebsd14.3
podman push "${IMAGE_PATH}"/uv:freebsd14.3

