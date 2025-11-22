#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing nginx-mainline to ${IMAGE_PATH}"

echo
echo "nginx:mainline-freebsd"
podman tag localhost/nginx:mainline-freebsd "${IMAGE_PATH}"/nginx:mainline-freebsd
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd

echo
echo "nginx:mainline-freebsd14"
podman tag localhost/nginx:mainline-freebsd14 "${IMAGE_PATH}"/nginx:mainline-freebsd14
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd14

echo
echo "nginx:mainline-freebsd14.3"
podman tag localhost/nginx:mainline-freebsd14.3 "${IMAGE_PATH}"/nginx:mainline-freebsd14.3
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing nginx-mainline to ${IMAGE_PATH}"

echo
echo "nginx:mainline-freebsd"
podman tag localhost/nginx:mainline-freebsd "${IMAGE_PATH}"/nginx:mainline-freebsd
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd

echo
echo "nginx:mainline-freebsd14"
podman tag localhost/nginx:mainline-freebsd14 "${IMAGE_PATH}"/nginx:mainline-freebsd14
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd14

echo
echo "nginx:mainline-freebsd14.3"
podman tag localhost/nginx:mainline-freebsd14.3 "${IMAGE_PATH}"/nginx:mainline-freebsd14.3
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing nginx-mainline to ${IMAGE_PATH}"

echo
echo "nginx:mainline-freebsd"
podman tag localhost/nginx:mainline-freebsd "${IMAGE_PATH}"/nginx:mainline-freebsd
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd

echo
echo "nginx:mainline-freebsd14"
podman tag localhost/nginx:mainline-freebsd14 "${IMAGE_PATH}"/nginx:mainline-freebsd14
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd14

echo
echo "nginx:mainline-freebsd14.3"
podman tag localhost/nginx:mainline-freebsd14.3 "${IMAGE_PATH}"/nginx:mainline-freebsd14.3
podman push "${IMAGE_PATH}"/nginx:mainline-freebsd14.3

