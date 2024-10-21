#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
--tag nginx-base:${VERSION} --tag nginx-base:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file nginx-base/Containerfile .
