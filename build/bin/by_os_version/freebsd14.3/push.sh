#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/base/runtime/push.sh
build/images/14.3/zfs/runtime/push.sh
build/images/14.3/golang/1.20/push.sh
build/images/14.3/golang/1.21/push.sh
build/images/14.3/golang/1.22/push.sh
build/images/14.3/golang/1.23/push.sh
build/images/14.3/golang/1.24/push.sh
build/images/14.3/golang/1.25/push.sh
build/images/14.3/nginx/stable/push.sh
build/images/14.3/nginx/mainline/push.sh
build/images/14.3/node/20/push.sh
build/images/14.3/node/22/push.sh
build/images/14.3/node/24/push.sh
build/images/14.3/node/25/push.sh
build/images/14.3/python/3.11/push.sh
build/images/14.3/uv/3.11/push.sh
build/images/14.3/postgres/13/push.sh
build/images/14.3/postgres/14/push.sh
build/images/14.3/postgres/15/push.sh
build/images/14.3/postgres/16/push.sh
build/images/14.3/postgres/17/push.sh
build/images/14.3/postgres/18/push.sh
