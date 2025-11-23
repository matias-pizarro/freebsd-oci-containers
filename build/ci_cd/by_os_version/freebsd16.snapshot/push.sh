#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/16.snap/base/runtime/ci_cd/push.sh
build/images/16.snap/zfs/runtime/ci_cd/push.sh
build/images/16.snap/golang/1.20/ci_cd/push.sh
build/images/16.snap/golang/1.21/ci_cd/push.sh
build/images/16.snap/golang/1.22/ci_cd/push.sh
build/images/16.snap/golang/1.23/ci_cd/push.sh
build/images/16.snap/golang/1.24/ci_cd/push.sh
build/images/16.snap/golang/1.25/ci_cd/push.sh
build/images/16.snap/nginx/stable/ci_cd/push.sh
build/images/16.snap/nginx/mainline/ci_cd/push.sh
build/images/16.snap/node/20/ci_cd/push.sh
build/images/16.snap/node/22/ci_cd/push.sh
build/images/16.snap/node/24/ci_cd/push.sh
build/images/16.snap/node/25/ci_cd/push.sh
build/images/16.snap/python/3.11/ci_cd/push.sh
build/images/16.snap/uv/3.11/ci_cd/push.sh
build/images/16.snap/postgres/13/ci_cd/push.sh
build/images/16.snap/postgres/14/ci_cd/push.sh
build/images/16.snap/postgres/15/ci_cd/push.sh
build/images/16.snap/postgres/16/ci_cd/push.sh
build/images/16.snap/postgres/17/ci_cd/push.sh
build/images/16.snap/postgres/18/ci_cd/push.sh
