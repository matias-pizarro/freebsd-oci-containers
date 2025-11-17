#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.snap/base/runtime/push.sh
build/images/15.snap/zfs/runtime/push.sh
build/images/15.snap/golang/1.20/push.sh
build/images/15.snap/golang/1.21/push.sh
build/images/15.snap/golang/1.22/push.sh
build/images/15.snap/golang/1.23/push.sh
build/images/15.snap/golang/1.24/push.sh
build/images/15.snap/golang/1.25/push.sh
build/images/15.snap/nginx/stable/push.sh
build/images/15.snap/nginx/mainline/push.sh
build/images/15.snap/node/20/push.sh
build/images/15.snap/node/22/push.sh
build/images/15.snap/node/24/push.sh
build/images/15.snap/node/25/push.sh
build/images/15.snap/python/3.11/push.sh
build/images/15.snap/uv/3.11/push.sh
build/images/15.snap/postgres/13/push.sh
build/images/15.snap/postgres/14/push.sh
build/images/15.snap/postgres/15/push.sh
build/images/15.snap/postgres/16/push.sh
build/images/15.snap/postgres/17/push.sh
build/images/15.snap/postgres/18/push.sh
