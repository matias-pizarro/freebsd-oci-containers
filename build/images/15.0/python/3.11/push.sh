#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd15"
podman tag localhost/python:3-freebsd15 "${IMAGE_PATH}"/python:3-freebsd15
podman push "${IMAGE_PATH}"/python:3-freebsd15

echo
echo "python:3-freebsd15.0"
podman tag localhost/python:3-freebsd15.0 "${IMAGE_PATH}"/python:3-freebsd15.0
podman push "${IMAGE_PATH}"/python:3-freebsd15.0

echo
echo "python:3.11-freebsd15"
podman tag localhost/python:3.11-freebsd15 "${IMAGE_PATH}"/python:3.11-freebsd15
podman push "${IMAGE_PATH}"/python:3.11-freebsd15

echo
echo "python:3.11-freebsd15.0"
podman tag localhost/python:3.11-freebsd15.0 "${IMAGE_PATH}"/python:3.11-freebsd15.0
podman push "${IMAGE_PATH}"/python:3.11-freebsd15.0

echo
echo "python:freebsd15"
podman tag localhost/python:freebsd15 "${IMAGE_PATH}"/python:freebsd15
podman push "${IMAGE_PATH}"/python:freebsd15

echo
echo "python:freebsd15.0"
podman tag localhost/python:freebsd15.0 "${IMAGE_PATH}"/python:freebsd15.0
podman push "${IMAGE_PATH}"/python:freebsd15.0


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd15"
podman tag localhost/python:3-freebsd15 "${IMAGE_PATH}"/python:3-freebsd15
podman push "${IMAGE_PATH}"/python:3-freebsd15

echo
echo "python:3-freebsd15.0"
podman tag localhost/python:3-freebsd15.0 "${IMAGE_PATH}"/python:3-freebsd15.0
podman push "${IMAGE_PATH}"/python:3-freebsd15.0

echo
echo "python:3.11-freebsd15"
podman tag localhost/python:3.11-freebsd15 "${IMAGE_PATH}"/python:3.11-freebsd15
podman push "${IMAGE_PATH}"/python:3.11-freebsd15

echo
echo "python:3.11-freebsd15.0"
podman tag localhost/python:3.11-freebsd15.0 "${IMAGE_PATH}"/python:3.11-freebsd15.0
podman push "${IMAGE_PATH}"/python:3.11-freebsd15.0

echo
echo "python:freebsd15"
podman tag localhost/python:freebsd15 "${IMAGE_PATH}"/python:freebsd15
podman push "${IMAGE_PATH}"/python:freebsd15

echo
echo "python:freebsd15.0"
podman tag localhost/python:freebsd15.0 "${IMAGE_PATH}"/python:freebsd15.0
podman push "${IMAGE_PATH}"/python:freebsd15.0


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd15"
podman tag localhost/python:3-freebsd15 "${IMAGE_PATH}"/python:3-freebsd15
podman push "${IMAGE_PATH}"/python:3-freebsd15

echo
echo "python:3-freebsd15.0"
podman tag localhost/python:3-freebsd15.0 "${IMAGE_PATH}"/python:3-freebsd15.0
podman push "${IMAGE_PATH}"/python:3-freebsd15.0

echo
echo "python:3.11-freebsd15"
podman tag localhost/python:3.11-freebsd15 "${IMAGE_PATH}"/python:3.11-freebsd15
podman push "${IMAGE_PATH}"/python:3.11-freebsd15

echo
echo "python:3.11-freebsd15.0"
podman tag localhost/python:3.11-freebsd15.0 "${IMAGE_PATH}"/python:3.11-freebsd15.0
podman push "${IMAGE_PATH}"/python:3.11-freebsd15.0

echo
echo "python:freebsd15"
podman tag localhost/python:freebsd15 "${IMAGE_PATH}"/python:freebsd15
podman push "${IMAGE_PATH}"/python:freebsd15

echo
echo "python:freebsd15.0"
podman tag localhost/python:freebsd15.0 "${IMAGE_PATH}"/python:freebsd15.0
podman push "${IMAGE_PATH}"/python:freebsd15.0

