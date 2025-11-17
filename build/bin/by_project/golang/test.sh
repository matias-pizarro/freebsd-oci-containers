#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/golang/1.20/test.sh
build/images/14.3/golang/1.21/test.sh
build/images/14.3/golang/1.22/test.sh
build/images/14.3/golang/1.23/test.sh
build/images/14.3/golang/1.24/test.sh
build/images/14.3/golang/1.25/test.sh
build/images/14.snap/golang/1.20/test.sh
build/images/14.snap/golang/1.21/test.sh
build/images/14.snap/golang/1.22/test.sh
build/images/14.snap/golang/1.23/test.sh
build/images/14.snap/golang/1.24/test.sh
build/images/14.snap/golang/1.25/test.sh
build/images/15.0/golang/1.20/test.sh
build/images/15.0/golang/1.21/test.sh
build/images/15.0/golang/1.22/test.sh
build/images/15.0/golang/1.23/test.sh
build/images/15.0/golang/1.24/test.sh
build/images/15.0/golang/1.25/test.sh
build/images/15.snap/golang/1.20/test.sh
build/images/15.snap/golang/1.21/test.sh
build/images/15.snap/golang/1.22/test.sh
build/images/15.snap/golang/1.23/test.sh
build/images/15.snap/golang/1.24/test.sh
build/images/15.snap/golang/1.25/test.sh
build/images/16.snap/golang/1.20/test.sh
build/images/16.snap/golang/1.21/test.sh
build/images/16.snap/golang/1.22/test.sh
build/images/16.snap/golang/1.23/test.sh
build/images/16.snap/golang/1.24/test.sh
build/images/16.snap/golang/1.25/test.sh
