#!/bin/sh

cd $(dirname "$0")

find $(pwd) -name build.sh -exec sh -c {} \;

podman image prune -f
