#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd14.snapshot"
podman tag localhost/nginx:freebsd14.snapshot "${IMAGE_PATH}"/nginx:freebsd14.snapshot
podman push "${IMAGE_PATH}"/nginx:freebsd14.snapshot

echo
echo "nginx:stable-freebsd14.snapshot"
podman tag localhost/nginx:stable-freebsd14.snapshot "${IMAGE_PATH}"/nginx:stable-freebsd14.snapshot
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd14.snapshot"
podman tag localhost/nginx:freebsd14.snapshot "${IMAGE_PATH}"/nginx:freebsd14.snapshot
podman push "${IMAGE_PATH}"/nginx:freebsd14.snapshot

echo
echo "nginx:stable-freebsd14.snapshot"
podman tag localhost/nginx:stable-freebsd14.snapshot "${IMAGE_PATH}"/nginx:stable-freebsd14.snapshot
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd14.snapshot"
podman tag localhost/nginx:freebsd14.snapshot "${IMAGE_PATH}"/nginx:freebsd14.snapshot
podman push "${IMAGE_PATH}"/nginx:freebsd14.snapshot

echo
echo "nginx:stable-freebsd14.snapshot"
podman tag localhost/nginx:stable-freebsd14.snapshot "${IMAGE_PATH}"/nginx:stable-freebsd14.snapshot
podman push "${IMAGE_PATH}"/nginx:stable-freebsd14.snapshot

