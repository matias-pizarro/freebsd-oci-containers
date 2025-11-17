#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd15"
podman tag localhost/nginx:freebsd15 "${IMAGE_PATH}"/nginx:freebsd15
podman push "${IMAGE_PATH}"/nginx:freebsd15

echo
echo "nginx:freebsd15.0"
podman tag localhost/nginx:freebsd15.0 "${IMAGE_PATH}"/nginx:freebsd15.0
podman push "${IMAGE_PATH}"/nginx:freebsd15.0

echo
echo "nginx:stable-freebsd15"
podman tag localhost/nginx:stable-freebsd15 "${IMAGE_PATH}"/nginx:stable-freebsd15
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15

echo
echo "nginx:stable-freebsd15.0"
podman tag localhost/nginx:stable-freebsd15.0 "${IMAGE_PATH}"/nginx:stable-freebsd15.0
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15.0


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd15"
podman tag localhost/nginx:freebsd15 "${IMAGE_PATH}"/nginx:freebsd15
podman push "${IMAGE_PATH}"/nginx:freebsd15

echo
echo "nginx:freebsd15.0"
podman tag localhost/nginx:freebsd15.0 "${IMAGE_PATH}"/nginx:freebsd15.0
podman push "${IMAGE_PATH}"/nginx:freebsd15.0

echo
echo "nginx:stable-freebsd15"
podman tag localhost/nginx:stable-freebsd15 "${IMAGE_PATH}"/nginx:stable-freebsd15
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15

echo
echo "nginx:stable-freebsd15.0"
podman tag localhost/nginx:stable-freebsd15.0 "${IMAGE_PATH}"/nginx:stable-freebsd15.0
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15.0


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd15"
podman tag localhost/nginx:freebsd15 "${IMAGE_PATH}"/nginx:freebsd15
podman push "${IMAGE_PATH}"/nginx:freebsd15

echo
echo "nginx:freebsd15.0"
podman tag localhost/nginx:freebsd15.0 "${IMAGE_PATH}"/nginx:freebsd15.0
podman push "${IMAGE_PATH}"/nginx:freebsd15.0

echo
echo "nginx:stable-freebsd15"
podman tag localhost/nginx:stable-freebsd15 "${IMAGE_PATH}"/nginx:stable-freebsd15
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15

echo
echo "nginx:stable-freebsd15.0"
podman tag localhost/nginx:stable-freebsd15.0 "${IMAGE_PATH}"/nginx:stable-freebsd15.0
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15.0

