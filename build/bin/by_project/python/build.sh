#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/python/3.11/build.sh
build/images/14.snap/python/3.11/build.sh
build/images/15.0/python/3.11/build.sh
build/images/15.snap/python/3.11/build.sh
build/images/16.snap/python/3.11/build.sh
