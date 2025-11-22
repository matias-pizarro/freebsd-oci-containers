#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd"
podman tag localhost/nginx:freebsd "${IMAGE_PATH}"/nginx:freebsd
podman push "${IMAGE_PATH}"/nginx:freebsd

echo
echo "nginx:freebsd14"
podman tag localhost/nginx:freebsd14 "${IMAGE_PATH}"/nginx:freebsd14
podman push "${IMAGE_PATH}"/nginx:freebsd14

echo
echo "nginx:freebsd14.3"
podman tag localhost/nginx:freebsd14.3 "${IMAGE_PATH}"/nginx:freebsd14.3
podman push "${IMAGE_PATH}"/nginx:freebsd14.3

echo
echo "nginx:stable-freebsd"
podman tag localhost/nginx:stable-freebsd "${IMAGE_PATH}"/nginx:stable-freebsd
podman push "${IMAGE_PATH}"/nginx:stable-freebsd

echo
echo "nginx:stable-freebsd14"
podman tag localhost/nginx:stable-freebsd14 "${IMAGE_PATH}"/nginx:stable-freebsd14
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14

echo
echo "nginx:stable-freebsd14.3"
podman tag localhost/nginx:stable-freebsd14.3 "${IMAGE_PATH}"/nginx:stable-freebsd14.3
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd"
podman tag localhost/nginx:freebsd "${IMAGE_PATH}"/nginx:freebsd
podman push "${IMAGE_PATH}"/nginx:freebsd

echo
echo "nginx:freebsd14"
podman tag localhost/nginx:freebsd14 "${IMAGE_PATH}"/nginx:freebsd14
podman push "${IMAGE_PATH}"/nginx:freebsd14

echo
echo "nginx:freebsd14.3"
podman tag localhost/nginx:freebsd14.3 "${IMAGE_PATH}"/nginx:freebsd14.3
podman push "${IMAGE_PATH}"/nginx:freebsd14.3

echo
echo "nginx:stable-freebsd"
podman tag localhost/nginx:stable-freebsd "${IMAGE_PATH}"/nginx:stable-freebsd
podman push "${IMAGE_PATH}"/nginx:stable-freebsd

echo
echo "nginx:stable-freebsd14"
podman tag localhost/nginx:stable-freebsd14 "${IMAGE_PATH}"/nginx:stable-freebsd14
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14

echo
echo "nginx:stable-freebsd14.3"
podman tag localhost/nginx:stable-freebsd14.3 "${IMAGE_PATH}"/nginx:stable-freebsd14.3
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd"
podman tag localhost/nginx:freebsd "${IMAGE_PATH}"/nginx:freebsd
podman push "${IMAGE_PATH}"/nginx:freebsd

echo
echo "nginx:freebsd14"
podman tag localhost/nginx:freebsd14 "${IMAGE_PATH}"/nginx:freebsd14
podman push "${IMAGE_PATH}"/nginx:freebsd14

echo
echo "nginx:freebsd14.3"
podman tag localhost/nginx:freebsd14.3 "${IMAGE_PATH}"/nginx:freebsd14.3
podman push "${IMAGE_PATH}"/nginx:freebsd14.3

echo
echo "nginx:stable-freebsd"
podman tag localhost/nginx:stable-freebsd "${IMAGE_PATH}"/nginx:stable-freebsd
podman push "${IMAGE_PATH}"/nginx:stable-freebsd

echo
echo "nginx:stable-freebsd14"
podman tag localhost/nginx:stable-freebsd14 "${IMAGE_PATH}"/nginx:stable-freebsd14
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14

echo
echo "nginx:stable-freebsd14.3"
podman tag localhost/nginx:stable-freebsd14.3 "${IMAGE_PATH}"/nginx:stable-freebsd14.3
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14.3

