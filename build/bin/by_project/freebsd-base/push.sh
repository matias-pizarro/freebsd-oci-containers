#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/base/runtime/push.sh
build/images/14.snap/base/runtime/push.sh
build/images/15.0/base/runtime/push.sh
build/images/15.snap/base/runtime/push.sh
build/images/16.snap/base/runtime/push.sh
