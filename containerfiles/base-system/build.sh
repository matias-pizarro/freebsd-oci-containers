#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
--tag base-system:${VERSION} --tag base-system:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file base-system/Containerfile .
