#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing golang-1.21.13.5 to ${IMAGE_PATH}"

echo
echo "golang:1.21-freebsd14.snapshot"
podman tag localhost/golang:1.21-freebsd14.snapshot "${IMAGE_PATH}"/golang:1.21-freebsd14.snapshot
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14.snapshot

echo
echo "golang:1.21.13-freebsd14.snapshot"
podman tag localhost/golang:1.21.13-freebsd14.snapshot "${IMAGE_PATH}"/golang:1.21.13-freebsd14.snapshot
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing golang-1.21.13.5 to ${IMAGE_PATH}"

echo
echo "golang:1.21-freebsd14.snapshot"
podman tag localhost/golang:1.21-freebsd14.snapshot "${IMAGE_PATH}"/golang:1.21-freebsd14.snapshot
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14.snapshot

echo
echo "golang:1.21.13-freebsd14.snapshot"
podman tag localhost/golang:1.21.13-freebsd14.snapshot "${IMAGE_PATH}"/golang:1.21.13-freebsd14.snapshot
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing golang-1.21.13.5 to ${IMAGE_PATH}"

echo
echo "golang:1.21-freebsd14.snapshot"
podman tag localhost/golang:1.21-freebsd14.snapshot "${IMAGE_PATH}"/golang:1.21-freebsd14.snapshot
podman push "${IMAGE_PATH}"/golang:1.21-freebsd14.snapshot

echo
echo "golang:1.21.13-freebsd14.snapshot"
podman tag localhost/golang:1.21.13-freebsd14.snapshot "${IMAGE_PATH}"/golang:1.21.13-freebsd14.snapshot
podman push "${IMAGE_PATH}"/golang:1.21.13-freebsd14.snapshot

