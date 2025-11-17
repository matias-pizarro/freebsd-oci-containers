#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/base/runtime/build.sh
build/images/14.3/zfs/runtime/build.sh
build/images/14.3/golang/1.20/build.sh
build/images/14.3/golang/1.21/build.sh
build/images/14.3/golang/1.22/build.sh
build/images/14.3/golang/1.23/build.sh
build/images/14.3/golang/1.24/build.sh
build/images/14.3/golang/1.25/build.sh
build/images/14.3/nginx/stable/build.sh
build/images/14.3/nginx/mainline/build.sh
build/images/14.3/node/20/build.sh
build/images/14.3/node/22/build.sh
build/images/14.3/node/24/build.sh
build/images/14.3/node/25/build.sh
build/images/14.3/python/3.11/build.sh
build/images/14.3/uv/3.11/build.sh
build/images/14.3/postgres/13/build.sh
build/images/14.3/postgres/14/build.sh
build/images/14.3/postgres/15/build.sh
build/images/14.3/postgres/16/build.sh
build/images/14.3/postgres/17/build.sh
build/images/14.3/postgres/18/build.sh
