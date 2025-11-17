#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/uv/3.11/test.sh
build/images/14.snap/uv/3.11/test.sh
build/images/15.0/uv/3.11/test.sh
build/images/15.snap/uv/3.11/test.sh
build/images/16.snap/uv/3.11/test.sh
