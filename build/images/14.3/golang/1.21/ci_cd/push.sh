#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing golang-1.21.13.5 to ${IMAGE_PATH}"

echo
echo "golang:1.21-freebsd"
podman tag localhost/golang:1.21-freebsd "${IMAGE_PATH}"/golang:1.21-freebsd
podman push "${IMAGE_PATH}"/golang:1.21-freebsd

echo
echo "golang:1.21-freebsd14"
podman tag localhost/golang:1.21-freebsd14 "${IMAGE_PATH}"/golang:1.21-freebsd14
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14

echo
echo "golang:1.21-freebsd14.3"
podman tag localhost/golang:1.21-freebsd14.3 "${IMAGE_PATH}"/golang:1.21-freebsd14.3
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14.3

echo
echo "golang:1.21.13-freebsd"
podman tag localhost/golang:1.21.13-freebsd "${IMAGE_PATH}"/golang:1.21.13-freebsd
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd

echo
echo "golang:1.21.13-freebsd14"
podman tag localhost/golang:1.21.13-freebsd14 "${IMAGE_PATH}"/golang:1.21.13-freebsd14
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14

echo
echo "golang:1.21.13-freebsd14.3"
podman tag localhost/golang:1.21.13-freebsd14.3 "${IMAGE_PATH}"/golang:1.21.13-freebsd14.3
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing golang-1.21.13.5 to ${IMAGE_PATH}"

echo
echo "golang:1.21-freebsd"
podman tag localhost/golang:1.21-freebsd "${IMAGE_PATH}"/golang:1.21-freebsd
podman push "${IMAGE_PATH}"/golang:1.21-freebsd

echo
echo "golang:1.21-freebsd14"
podman tag localhost/golang:1.21-freebsd14 "${IMAGE_PATH}"/golang:1.21-freebsd14
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14

echo
echo "golang:1.21-freebsd14.3"
podman tag localhost/golang:1.21-freebsd14.3 "${IMAGE_PATH}"/golang:1.21-freebsd14.3
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14.3

echo
echo "golang:1.21.13-freebsd"
podman tag localhost/golang:1.21.13-freebsd "${IMAGE_PATH}"/golang:1.21.13-freebsd
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd

echo
echo "golang:1.21.13-freebsd14"
podman tag localhost/golang:1.21.13-freebsd14 "${IMAGE_PATH}"/golang:1.21.13-freebsd14
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14

echo
echo "golang:1.21.13-freebsd14.3"
podman tag localhost/golang:1.21.13-freebsd14.3 "${IMAGE_PATH}"/golang:1.21.13-freebsd14.3
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing golang-1.21.13.5 to ${IMAGE_PATH}"

echo
echo "golang:1.21-freebsd"
podman tag localhost/golang:1.21-freebsd "${IMAGE_PATH}"/golang:1.21-freebsd
podman push "${IMAGE_PATH}"/golang:1.21-freebsd

echo
echo "golang:1.21-freebsd14"
podman tag localhost/golang:1.21-freebsd14 "${IMAGE_PATH}"/golang:1.21-freebsd14
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14

echo
echo "golang:1.21-freebsd14.3"
podman tag localhost/golang:1.21-freebsd14.3 "${IMAGE_PATH}"/golang:1.21-freebsd14.3
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14.3

echo
echo "golang:1.21.13-freebsd"
podman tag localhost/golang:1.21.13-freebsd "${IMAGE_PATH}"/golang:1.21.13-freebsd
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd

echo
echo "golang:1.21.13-freebsd14"
podman tag localhost/golang:1.21.13-freebsd14 "${IMAGE_PATH}"/golang:1.21.13-freebsd14
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14

echo
echo "golang:1.21.13-freebsd14.3"
podman tag localhost/golang:1.21.13-freebsd14.3 "${IMAGE_PATH}"/golang:1.21.13-freebsd14.3
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14.3

