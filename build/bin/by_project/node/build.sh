#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/node/20/build.sh
build/images/14.3/node/22/build.sh
build/images/14.3/node/24/build.sh
build/images/14.3/node/25/build.sh
build/images/14.snap/node/20/build.sh
build/images/14.snap/node/22/build.sh
build/images/14.snap/node/24/build.sh
build/images/14.snap/node/25/build.sh
build/images/15.0/node/20/build.sh
build/images/15.0/node/22/build.sh
build/images/15.0/node/24/build.sh
build/images/15.0/node/25/build.sh
build/images/15.snap/node/20/build.sh
build/images/15.snap/node/22/build.sh
build/images/15.snap/node/24/build.sh
build/images/15.snap/node/25/build.sh
build/images/16.snap/node/20/build.sh
build/images/16.snap/node/22/build.sh
build/images/16.snap/node/24/build.sh
build/images/16.snap/node/25/build.sh
