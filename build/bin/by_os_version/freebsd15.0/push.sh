#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.0/base/runtime/push.sh
build/images/15.0/zfs/runtime/push.sh
build/images/15.0/golang/1.20/push.sh
build/images/15.0/golang/1.21/push.sh
build/images/15.0/golang/1.22/push.sh
build/images/15.0/golang/1.23/push.sh
build/images/15.0/golang/1.24/push.sh
build/images/15.0/golang/1.25/push.sh
build/images/15.0/nginx/stable/push.sh
build/images/15.0/nginx/mainline/push.sh
build/images/15.0/node/20/push.sh
build/images/15.0/node/22/push.sh
build/images/15.0/node/24/push.sh
build/images/15.0/node/25/push.sh
build/images/15.0/python/3.11/push.sh
build/images/15.0/uv/3.11/push.sh
build/images/15.0/postgres/13/push.sh
build/images/15.0/postgres/14/push.sh
build/images/15.0/postgres/15/push.sh
build/images/15.0/postgres/16/push.sh
build/images/15.0/postgres/17/push.sh
build/images/15.0/postgres/18/push.sh
