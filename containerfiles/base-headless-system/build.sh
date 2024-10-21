#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
--tag base-headless-system:${VERSION} --tag base-headless-system:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file base-headless-system/Containerfile .
