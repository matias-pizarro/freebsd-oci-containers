#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.snap/base/runtime/test.sh
build/images/15.snap/zfs/runtime/test.sh
build/images/15.snap/golang/1.20/test.sh
build/images/15.snap/golang/1.21/test.sh
build/images/15.snap/golang/1.22/test.sh
build/images/15.snap/golang/1.23/test.sh
build/images/15.snap/golang/1.24/test.sh
build/images/15.snap/golang/1.25/test.sh
build/images/15.snap/nginx/stable/test.sh
build/images/15.snap/nginx/mainline/test.sh
build/images/15.snap/node/20/test.sh
build/images/15.snap/node/22/test.sh
build/images/15.snap/node/24/test.sh
build/images/15.snap/node/25/test.sh
build/images/15.snap/python/3.11/test.sh
build/images/15.snap/uv/3.11/test.sh
build/images/15.snap/postgres/13/test.sh
build/images/15.snap/postgres/14/test.sh
build/images/15.snap/postgres/15/test.sh
build/images/15.snap/postgres/16/test.sh
build/images/15.snap/postgres/17/test.sh
build/images/15.snap/postgres/18/test.sh
