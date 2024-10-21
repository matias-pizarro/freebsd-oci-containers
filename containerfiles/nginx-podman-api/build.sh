#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# podman api
podman build \
--tag nginx-podman-api:${VERSION} --tag nginx-podman-api:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file nginx-podman-api/Containerfile .
