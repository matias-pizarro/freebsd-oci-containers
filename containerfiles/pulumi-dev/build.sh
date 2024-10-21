#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
--tag pulumi-dev:${VERSION} --tag pulumi-dev:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file pulumi-dev/Containerfile .
