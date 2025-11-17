#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/golang/1.20/build.sh
build/images/14.3/golang/1.21/build.sh
build/images/14.3/golang/1.22/build.sh
build/images/14.3/golang/1.23/build.sh
build/images/14.3/golang/1.24/build.sh
build/images/14.3/golang/1.25/build.sh
build/images/14.snap/golang/1.20/build.sh
build/images/14.snap/golang/1.21/build.sh
build/images/14.snap/golang/1.22/build.sh
build/images/14.snap/golang/1.23/build.sh
build/images/14.snap/golang/1.24/build.sh
build/images/14.snap/golang/1.25/build.sh
build/images/15.0/golang/1.20/build.sh
build/images/15.0/golang/1.21/build.sh
build/images/15.0/golang/1.22/build.sh
build/images/15.0/golang/1.23/build.sh
build/images/15.0/golang/1.24/build.sh
build/images/15.0/golang/1.25/build.sh
build/images/15.snap/golang/1.20/build.sh
build/images/15.snap/golang/1.21/build.sh
build/images/15.snap/golang/1.22/build.sh
build/images/15.snap/golang/1.23/build.sh
build/images/15.snap/golang/1.24/build.sh
build/images/15.snap/golang/1.25/build.sh
build/images/16.snap/golang/1.20/build.sh
build/images/16.snap/golang/1.21/build.sh
build/images/16.snap/golang/1.22/build.sh
build/images/16.snap/golang/1.23/build.sh
build/images/16.snap/golang/1.24/build.sh
build/images/16.snap/golang/1.25/build.sh
