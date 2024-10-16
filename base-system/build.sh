#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
    -t base-system:${VERSION} -t base-system:latest \
    -v /var/cache/pkg:/var/cache/pkg \
    -f base-system/Containerfile .
