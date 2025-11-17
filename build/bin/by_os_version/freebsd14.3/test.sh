#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/base/runtime/test.sh
build/images/14.3/zfs/runtime/test.sh
build/images/14.3/golang/1.20/test.sh
build/images/14.3/golang/1.21/test.sh
build/images/14.3/golang/1.22/test.sh
build/images/14.3/golang/1.23/test.sh
build/images/14.3/golang/1.24/test.sh
build/images/14.3/golang/1.25/test.sh
build/images/14.3/nginx/stable/test.sh
build/images/14.3/nginx/mainline/test.sh
build/images/14.3/node/20/test.sh
build/images/14.3/node/22/test.sh
build/images/14.3/node/24/test.sh
build/images/14.3/node/25/test.sh
build/images/14.3/python/3.11/test.sh
build/images/14.3/uv/3.11/test.sh
build/images/14.3/postgres/13/test.sh
build/images/14.3/postgres/14/test.sh
build/images/14.3/postgres/15/test.sh
build/images/14.3/postgres/16/test.sh
build/images/14.3/postgres/17/test.sh
build/images/14.3/postgres/18/test.sh
