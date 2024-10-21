#!/bin/sh

cd $(dirname "$0")
cd ..

# find $(pwd) -name build.sh -exec sh -c {} \;
./containerfiles/base-headless-system/build.sh
./containerfiles/base-system/build.sh
./containerfiles/nginx/build.sh
./containerfiles/nginx-podman-api/build.sh
./containerfiles/nginx-poudriere/build.sh
./containerfiles/pulumi-dev/build.sh

podman image prune -f
