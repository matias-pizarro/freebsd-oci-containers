#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing golang-1.23.12 to ${IMAGE_PATH}"

echo
echo "golang:1.23-freebsd15"
podman tag localhost/golang:1.23-freebsd15 "${IMAGE_PATH}"/golang:1.23-freebsd15
podman push "${IMAGE_PATH}"/golang:1.23-freebsd15

echo
echo "golang:1.23-freebsd15.0"
podman tag localhost/golang:1.23-freebsd15.0 "${IMAGE_PATH}"/golang:1.23-freebsd15.0
podman push "${IMAGE_PATH}"/golang:1.23-freebsd15.0

echo
echo "golang:1.23.12-freebsd15"
podman tag localhost/golang:1.23.12-freebsd15 "${IMAGE_PATH}"/golang:1.23.12-freebsd15
podman push "${IMAGE_PATH}"/golang:1.23.12-freebsd15

echo
echo "golang:1.23.12-freebsd15.0"
podman tag localhost/golang:1.23.12-freebsd15.0 "${IMAGE_PATH}"/golang:1.23.12-freebsd15.0
podman push "${IMAGE_PATH}"/golang:1.23.12-freebsd15.0


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing golang-1.23.12 to ${IMAGE_PATH}"

echo
echo "golang:1.23-freebsd15"
podman tag localhost/golang:1.23-freebsd15 "${IMAGE_PATH}"/golang:1.23-freebsd15
podman push "${IMAGE_PATH}"/golang:1.23-freebsd15

echo
echo "golang:1.23-freebsd15.0"
podman tag localhost/golang:1.23-freebsd15.0 "${IMAGE_PATH}"/golang:1.23-freebsd15.0
podman push "${IMAGE_PATH}"/golang:1.23-freebsd15.0

echo
echo "golang:1.23.12-freebsd15"
podman tag localhost/golang:1.23.12-freebsd15 "${IMAGE_PATH}"/golang:1.23.12-freebsd15
podman push "${IMAGE_PATH}"/golang:1.23.12-freebsd15

echo
echo "golang:1.23.12-freebsd15.0"
podman tag localhost/golang:1.23.12-freebsd15.0 "${IMAGE_PATH}"/golang:1.23.12-freebsd15.0
podman push "${IMAGE_PATH}"/golang:1.23.12-freebsd15.0


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing golang-1.23.12 to ${IMAGE_PATH}"

echo
echo "golang:1.23-freebsd15"
podman tag localhost/golang:1.23-freebsd15 "${IMAGE_PATH}"/golang:1.23-freebsd15
podman push "${IMAGE_PATH}"/golang:1.23-freebsd15

echo
echo "golang:1.23-freebsd15.0"
podman tag localhost/golang:1.23-freebsd15.0 "${IMAGE_PATH}"/golang:1.23-freebsd15.0
podman push "${IMAGE_PATH}"/golang:1.23-freebsd15.0

echo
echo "golang:1.23.12-freebsd15"
podman tag localhost/golang:1.23.12-freebsd15 "${IMAGE_PATH}"/golang:1.23.12-freebsd15
podman push "${IMAGE_PATH}"/golang:1.23.12-freebsd15

echo
echo "golang:1.23.12-freebsd15.0"
podman tag localhost/golang:1.23.12-freebsd15.0 "${IMAGE_PATH}"/golang:1.23.12-freebsd15.0
podman push "${IMAGE_PATH}"/golang:1.23.12-freebsd15.0

