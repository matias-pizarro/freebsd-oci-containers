#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.snap/base/runtime/ci_cd/test.sh
build/images/14.snap/zfs/runtime/ci_cd/test.sh
build/images/14.snap/golang/1.20/ci_cd/test.sh
build/images/14.snap/golang/1.21/ci_cd/test.sh
build/images/14.snap/golang/1.22/ci_cd/test.sh
build/images/14.snap/golang/1.23/ci_cd/test.sh
build/images/14.snap/golang/1.24/ci_cd/test.sh
build/images/14.snap/golang/1.25/ci_cd/test.sh
build/images/14.snap/nginx/stable/ci_cd/test.sh
build/images/14.snap/nginx/mainline/ci_cd/test.sh
build/images/14.snap/node/20/ci_cd/test.sh
build/images/14.snap/node/22/ci_cd/test.sh
build/images/14.snap/node/24/ci_cd/test.sh
build/images/14.snap/node/25/ci_cd/test.sh
build/images/14.snap/python/3.11/ci_cd/test.sh
build/images/14.snap/uv/3.11/ci_cd/test.sh
build/images/14.snap/postgres/13/ci_cd/test.sh
build/images/14.snap/postgres/14/ci_cd/test.sh
build/images/14.snap/postgres/15/ci_cd/test.sh
build/images/14.snap/postgres/16/ci_cd/test.sh
build/images/14.snap/postgres/17/ci_cd/test.sh
build/images/14.snap/postgres/18/ci_cd/test.sh
