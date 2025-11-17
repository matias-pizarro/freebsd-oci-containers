#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/postgres/13/test.sh
build/images/14.3/postgres/14/test.sh
build/images/14.3/postgres/15/test.sh
build/images/14.3/postgres/16/test.sh
build/images/14.3/postgres/17/test.sh
build/images/14.3/postgres/18/test.sh
build/images/14.snap/postgres/13/test.sh
build/images/14.snap/postgres/14/test.sh
build/images/14.snap/postgres/15/test.sh
build/images/14.snap/postgres/16/test.sh
build/images/14.snap/postgres/17/test.sh
build/images/14.snap/postgres/18/test.sh
build/images/15.0/postgres/13/test.sh
build/images/15.0/postgres/14/test.sh
build/images/15.0/postgres/15/test.sh
build/images/15.0/postgres/16/test.sh
build/images/15.0/postgres/17/test.sh
build/images/15.0/postgres/18/test.sh
build/images/15.snap/postgres/13/test.sh
build/images/15.snap/postgres/14/test.sh
build/images/15.snap/postgres/15/test.sh
build/images/15.snap/postgres/16/test.sh
build/images/15.snap/postgres/17/test.sh
build/images/15.snap/postgres/18/test.sh
build/images/16.snap/postgres/13/test.sh
build/images/16.snap/postgres/14/test.sh
build/images/16.snap/postgres/15/test.sh
build/images/16.snap/postgres/16/test.sh
build/images/16.snap/postgres/17/test.sh
build/images/16.snap/postgres/18/test.sh
