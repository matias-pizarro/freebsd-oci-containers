#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
    -t base-headless-system:${VERSION} -t base-headless-system:latest \
    -v /var/cache/pkg:/var/cache/pkg \
    -f base-headless-system/Containerfile .
