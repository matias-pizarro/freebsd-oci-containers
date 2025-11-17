#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.snap/base/runtime/build.sh
build/images/15.snap/zfs/runtime/build.sh
build/images/15.snap/golang/1.20/build.sh
build/images/15.snap/golang/1.21/build.sh
build/images/15.snap/golang/1.22/build.sh
build/images/15.snap/golang/1.23/build.sh
build/images/15.snap/golang/1.24/build.sh
build/images/15.snap/golang/1.25/build.sh
build/images/15.snap/nginx/stable/build.sh
build/images/15.snap/nginx/mainline/build.sh
build/images/15.snap/node/20/build.sh
build/images/15.snap/node/22/build.sh
build/images/15.snap/node/24/build.sh
build/images/15.snap/node/25/build.sh
build/images/15.snap/python/3.11/build.sh
build/images/15.snap/uv/3.11/build.sh
build/images/15.snap/postgres/13/build.sh
build/images/15.snap/postgres/14/build.sh
build/images/15.snap/postgres/15/build.sh
build/images/15.snap/postgres/16/build.sh
build/images/15.snap/postgres/17/build.sh
build/images/15.snap/postgres/18/build.sh
