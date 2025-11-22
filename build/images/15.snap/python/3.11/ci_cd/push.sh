#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd15.snapshot"
podman tag localhost/python:3-freebsd15.snapshot "${IMAGE_PATH}"/python:3-freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:3-freebsd15.snapshot

echo
echo "python:3.11-freebsd15.snapshot"
podman tag localhost/python:3.11-freebsd15.snapshot "${IMAGE_PATH}"/python:3.11-freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:3.11-freebsd15.snapshot

echo
echo "python:freebsd15.snapshot"
podman tag localhost/python:freebsd15.snapshot "${IMAGE_PATH}"/python:freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:freebsd15.snapshot


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd15.snapshot"
podman tag localhost/python:3-freebsd15.snapshot "${IMAGE_PATH}"/python:3-freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:3-freebsd15.snapshot

echo
echo "python:3.11-freebsd15.snapshot"
podman tag localhost/python:3.11-freebsd15.snapshot "${IMAGE_PATH}"/python:3.11-freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:3.11-freebsd15.snapshot

echo
echo "python:freebsd15.snapshot"
podman tag localhost/python:freebsd15.snapshot "${IMAGE_PATH}"/python:freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:freebsd15.snapshot


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd15.snapshot"
podman tag localhost/python:3-freebsd15.snapshot "${IMAGE_PATH}"/python:3-freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:3-freebsd15.snapshot

echo
echo "python:3.11-freebsd15.snapshot"
podman tag localhost/python:3.11-freebsd15.snapshot "${IMAGE_PATH}"/python:3.11-freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:3.11-freebsd15.snapshot

echo
echo "python:freebsd15.snapshot"
podman tag localhost/python:freebsd15.snapshot "${IMAGE_PATH}"/python:freebsd15.snapshot
podman push "${IMAGE_PATH}"/python:freebsd15.snapshot

