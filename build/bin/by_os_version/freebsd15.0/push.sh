#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.0/base/runtime/ci_cd/push.sh
build/images/15.0/zfs/runtime/ci_cd/push.sh
build/images/15.0/golang/1.20/ci_cd/push.sh
build/images/15.0/golang/1.21/ci_cd/push.sh
build/images/15.0/golang/1.22/ci_cd/push.sh
build/images/15.0/golang/1.23/ci_cd/push.sh
build/images/15.0/golang/1.24/ci_cd/push.sh
build/images/15.0/golang/1.25/ci_cd/push.sh
build/images/15.0/nginx/stable/ci_cd/push.sh
build/images/15.0/nginx/mainline/ci_cd/push.sh
build/images/15.0/node/20/ci_cd/push.sh
build/images/15.0/node/22/ci_cd/push.sh
build/images/15.0/node/24/ci_cd/push.sh
build/images/15.0/node/25/ci_cd/push.sh
build/images/15.0/python/3.11/ci_cd/push.sh
build/images/15.0/uv/3.11/ci_cd/push.sh
build/images/15.0/postgres/13/ci_cd/push.sh
build/images/15.0/postgres/14/ci_cd/push.sh
build/images/15.0/postgres/15/ci_cd/push.sh
build/images/15.0/postgres/16/ci_cd/push.sh
build/images/15.0/postgres/17/ci_cd/push.sh
build/images/15.0/postgres/18/ci_cd/push.sh
