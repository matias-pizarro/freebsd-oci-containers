#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.0/base/runtime/build.sh
build/images/15.0/zfs/runtime/build.sh
build/images/15.0/golang/1.20/build.sh
build/images/15.0/golang/1.21/build.sh
build/images/15.0/golang/1.22/build.sh
build/images/15.0/golang/1.23/build.sh
build/images/15.0/golang/1.24/build.sh
build/images/15.0/golang/1.25/build.sh
build/images/15.0/nginx/stable/build.sh
build/images/15.0/nginx/mainline/build.sh
build/images/15.0/node/20/build.sh
build/images/15.0/node/22/build.sh
build/images/15.0/node/24/build.sh
build/images/15.0/node/25/build.sh
build/images/15.0/python/3.11/build.sh
build/images/15.0/uv/3.11/build.sh
build/images/15.0/postgres/13/build.sh
build/images/15.0/postgres/14/build.sh
build/images/15.0/postgres/15/build.sh
build/images/15.0/postgres/16/build.sh
build/images/15.0/postgres/17/build.sh
build/images/15.0/postgres/18/build.sh
