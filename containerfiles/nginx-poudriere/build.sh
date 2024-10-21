#!/bin/sh

cd $(dirname "$0")

VERSION=$(cat ./version)

cd ..

# base headless system
podman build \
--tag nginx-poudriere:${VERSION} --tag nginx-poudriere:latest \
--volume /var/cache/pkg:/var/cache/pkg \
--file nginx-poudriere/Containerfile .
