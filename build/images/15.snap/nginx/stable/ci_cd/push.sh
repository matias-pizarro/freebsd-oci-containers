#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd15.snapshot"
podman tag localhost/nginx:freebsd15.snapshot "${IMAGE_PATH}"/nginx:freebsd15.snapshot
podman push "${IMAGE_PATH}"/nginx:freebsd15.snapshot

echo
echo "nginx:stable-freebsd15.snapshot"
podman tag localhost/nginx:stable-freebsd15.snapshot "${IMAGE_PATH}"/nginx:stable-freebsd15.snapshot
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd15.snapshot"
podman tag localhost/nginx:freebsd15.snapshot "${IMAGE_PATH}"/nginx:freebsd15.snapshot
podman push "${IMAGE_PATH}"/nginx:freebsd15.snapshot

echo
echo "nginx:stable-freebsd15.snapshot"
podman tag localhost/nginx:stable-freebsd15.snapshot "${IMAGE_PATH}"/nginx:stable-freebsd15.snapshot
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing nginx-stable to ${IMAGE_PATH}"

echo
echo "nginx:freebsd15.snapshot"
podman tag localhost/nginx:freebsd15.snapshot "${IMAGE_PATH}"/nginx:freebsd15.snapshot
podman push "${IMAGE_PATH}"/nginx:freebsd15.snapshot

echo
echo "nginx:stable-freebsd15.snapshot"
podman tag localhost/nginx:stable-freebsd15.snapshot "${IMAGE_PATH}"/nginx:stable-freebsd15.snapshot
podman push "${IMAGE_PATH}"/nginx:stable-freebsd15.snapshot

