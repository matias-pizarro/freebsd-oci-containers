#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd14.snapshot"
podman tag localhost/python:3-freebsd14.snapshot "${IMAGE_PATH}"/python:3-freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:3-freebsd14.snapshot

echo
echo "python:3.11-freebsd14.snapshot"
podman tag localhost/python:3.11-freebsd14.snapshot "${IMAGE_PATH}"/python:3.11-freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:3.11-freebsd14.snapshot

echo
echo "python:freebsd14.snapshot"
podman tag localhost/python:freebsd14.snapshot "${IMAGE_PATH}"/python:freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:freebsd14.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd14.snapshot"
podman tag localhost/python:3-freebsd14.snapshot "${IMAGE_PATH}"/python:3-freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:3-freebsd14.snapshot

echo
echo "python:3.11-freebsd14.snapshot"
podman tag localhost/python:3.11-freebsd14.snapshot "${IMAGE_PATH}"/python:3.11-freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:3.11-freebsd14.snapshot

echo
echo "python:freebsd14.snapshot"
podman tag localhost/python:freebsd14.snapshot "${IMAGE_PATH}"/python:freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:freebsd14.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd14.snapshot"
podman tag localhost/python:3-freebsd14.snapshot "${IMAGE_PATH}"/python:3-freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:3-freebsd14.snapshot

echo
echo "python:3.11-freebsd14.snapshot"
podman tag localhost/python:3.11-freebsd14.snapshot "${IMAGE_PATH}"/python:3.11-freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:3.11-freebsd14.snapshot

echo
echo "python:freebsd14.snapshot"
podman tag localhost/python:freebsd14.snapshot "${IMAGE_PATH}"/python:freebsd14.snapshot
podman push "${IMAGE_PATH}"/python:freebsd14.snapshot

