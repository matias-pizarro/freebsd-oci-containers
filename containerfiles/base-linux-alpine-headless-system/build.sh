#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
--tag base-linux-alpine-headless-system:${VERSION} --tag base-linux-alpine-headless-system:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file base-linux-alpine-headless-system/Containerfile .
