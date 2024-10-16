#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
    -t nginx:${VERSION} -t nginx:latest \
    -v /var/cache/pkg:/var/cache/pkg \
    -f nginx/Containerfile .
