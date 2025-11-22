#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Github
echo
echo "################################################################################"
IMAGE_PATH="ghcr.io/matias-pizarro/freebsd-oci-containers"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd"
podman tag localhost/python:3-freebsd "${IMAGE_PATH}"/python:3-freebsd
podman push "${IMAGE_PATH}"/python:3-freebsd

echo
echo "python:3-freebsd14"
podman tag localhost/python:3-freebsd14 "${IMAGE_PATH}"/python:3-freebsd14
podman push "${IMAGE_PATH}"/python:3-freebsd14

echo
echo "python:3-freebsd14.3"
podman tag localhost/python:3-freebsd14.3 "${IMAGE_PATH}"/python:3-freebsd14.3
podman push "${IMAGE_PATH}"/python:3-freebsd14.3

echo
echo "python:3.11-freebsd"
podman tag localhost/python:3.11-freebsd "${IMAGE_PATH}"/python:3.11-freebsd
podman push "${IMAGE_PATH}"/python:3.11-freebsd

echo
echo "python:3.11-freebsd14"
podman tag localhost/python:3.11-freebsd14 "${IMAGE_PATH}"/python:3.11-freebsd14
podman push "${IMAGE_PATH}"/python:3.11-freebsd14

echo
echo "python:3.11-freebsd14.3"
podman tag localhost/python:3.11-freebsd14.3 "${IMAGE_PATH}"/python:3.11-freebsd14.3
podman push "${IMAGE_PATH}"/python:3.11-freebsd14.3

echo
echo "python:freebsd"
podman tag localhost/python:freebsd "${IMAGE_PATH}"/python:freebsd
podman push "${IMAGE_PATH}"/python:freebsd

echo
echo "python:freebsd14"
podman tag localhost/python:freebsd14 "${IMAGE_PATH}"/python:freebsd14
podman push "${IMAGE_PATH}"/python:freebsd14

echo
echo "python:freebsd14.3"
podman tag localhost/python:freebsd14.3 "${IMAGE_PATH}"/python:freebsd14.3
podman push "${IMAGE_PATH}"/python:freebsd14.3


# Docker
echo
echo "################################################################################"
IMAGE_PATH="docker.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd"
podman tag localhost/python:3-freebsd "${IMAGE_PATH}"/python:3-freebsd
podman push "${IMAGE_PATH}"/python:3-freebsd

echo
echo "python:3-freebsd14"
podman tag localhost/python:3-freebsd14 "${IMAGE_PATH}"/python:3-freebsd14
podman push "${IMAGE_PATH}"/python:3-freebsd14

echo
echo "python:3-freebsd14.3"
podman tag localhost/python:3-freebsd14.3 "${IMAGE_PATH}"/python:3-freebsd14.3
podman push "${IMAGE_PATH}"/python:3-freebsd14.3

echo
echo "python:3.11-freebsd"
podman tag localhost/python:3.11-freebsd "${IMAGE_PATH}"/python:3.11-freebsd
podman push "${IMAGE_PATH}"/python:3.11-freebsd

echo
echo "python:3.11-freebsd14"
podman tag localhost/python:3.11-freebsd14 "${IMAGE_PATH}"/python:3.11-freebsd14
podman push "${IMAGE_PATH}"/python:3.11-freebsd14

echo
echo "python:3.11-freebsd14.3"
podman tag localhost/python:3.11-freebsd14.3 "${IMAGE_PATH}"/python:3.11-freebsd14.3
podman push "${IMAGE_PATH}"/python:3.11-freebsd14.3

echo
echo "python:freebsd"
podman tag localhost/python:freebsd "${IMAGE_PATH}"/python:freebsd
podman push "${IMAGE_PATH}"/python:freebsd

echo
echo "python:freebsd14"
podman tag localhost/python:freebsd14 "${IMAGE_PATH}"/python:freebsd14
podman push "${IMAGE_PATH}"/python:freebsd14

echo
echo "python:freebsd14.3"
podman tag localhost/python:freebsd14.3 "${IMAGE_PATH}"/python:freebsd14.3
podman push "${IMAGE_PATH}"/python:freebsd14.3


# Quay
echo
echo "################################################################################"
IMAGE_PATH="quay.io/matiaspizarro"
echo "Pushing python-3.11 to ${IMAGE_PATH}"

echo
echo "python:3-freebsd"
podman tag localhost/python:3-freebsd "${IMAGE_PATH}"/python:3-freebsd
podman push "${IMAGE_PATH}"/python:3-freebsd

echo
echo "python:3-freebsd14"
podman tag localhost/python:3-freebsd14 "${IMAGE_PATH}"/python:3-freebsd14
podman push "${IMAGE_PATH}"/python:3-freebsd14

echo
echo "python:3-freebsd14.3"
podman tag localhost/python:3-freebsd14.3 "${IMAGE_PATH}"/python:3-freebsd14.3
podman push "${IMAGE_PATH}"/python:3-freebsd14.3

echo
echo "python:3.11-freebsd"
podman tag localhost/python:3.11-freebsd "${IMAGE_PATH}"/python:3.11-freebsd
podman push "${IMAGE_PATH}"/python:3.11-freebsd

echo
echo "python:3.11-freebsd14"
podman tag localhost/python:3.11-freebsd14 "${IMAGE_PATH}"/python:3.11-freebsd14
podman push "${IMAGE_PATH}"/python:3.11-freebsd14

echo
echo "python:3.11-freebsd14.3"
podman tag localhost/python:3.11-freebsd14.3 "${IMAGE_PATH}"/python:3.11-freebsd14.3
podman push "${IMAGE_PATH}"/python:3.11-freebsd14.3

echo
echo "python:freebsd"
podman tag localhost/python:freebsd "${IMAGE_PATH}"/python:freebsd
podman push "${IMAGE_PATH}"/python:freebsd

echo
echo "python:freebsd14"
podman tag localhost/python:freebsd14 "${IMAGE_PATH}"/python:freebsd14
podman push "${IMAGE_PATH}"/python:freebsd14

echo
echo "python:freebsd14.3"
podman tag localhost/python:freebsd14.3 "${IMAGE_PATH}"/python:freebsd14.3
podman push "${IMAGE_PATH}"/python:freebsd14.3

