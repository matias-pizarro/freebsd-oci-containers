#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/zfs/runtime/build.sh
build/images/14.snap/zfs/runtime/build.sh
build/images/15.0/zfs/runtime/build.sh
build/images/15.snap/zfs/runtime/build.sh
build/images/16.snap/zfs/runtime/build.sh
