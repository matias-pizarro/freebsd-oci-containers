#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
    -t pulumi-dev:${VERSION} -t pulumi-dev:latest \
    -v /var/cache/pkg:/var/cache/pkg \
    -f pulumi-dev/Containerfile .
