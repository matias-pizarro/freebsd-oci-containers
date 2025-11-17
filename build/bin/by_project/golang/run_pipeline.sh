#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/golang/1.20/run_pipeline.sh
build/images/14.3/golang/1.21/run_pipeline.sh
build/images/14.3/golang/1.22/run_pipeline.sh
build/images/14.3/golang/1.23/run_pipeline.sh
build/images/14.3/golang/1.24/run_pipeline.sh
build/images/14.3/golang/1.25/run_pipeline.sh
build/images/14.snap/golang/1.20/run_pipeline.sh
build/images/14.snap/golang/1.21/run_pipeline.sh
build/images/14.snap/golang/1.22/run_pipeline.sh
build/images/14.snap/golang/1.23/run_pipeline.sh
build/images/14.snap/golang/1.24/run_pipeline.sh
build/images/14.snap/golang/1.25/run_pipeline.sh
build/images/15.0/golang/1.20/run_pipeline.sh
build/images/15.0/golang/1.21/run_pipeline.sh
build/images/15.0/golang/1.22/run_pipeline.sh
build/images/15.0/golang/1.23/run_pipeline.sh
build/images/15.0/golang/1.24/run_pipeline.sh
build/images/15.0/golang/1.25/run_pipeline.sh
build/images/15.snap/golang/1.20/run_pipeline.sh
build/images/15.snap/golang/1.21/run_pipeline.sh
build/images/15.snap/golang/1.22/run_pipeline.sh
build/images/15.snap/golang/1.23/run_pipeline.sh
build/images/15.snap/golang/1.24/run_pipeline.sh
build/images/15.snap/golang/1.25/run_pipeline.sh
build/images/16.snap/golang/1.20/run_pipeline.sh
build/images/16.snap/golang/1.21/run_pipeline.sh
build/images/16.snap/golang/1.22/run_pipeline.sh
build/images/16.snap/golang/1.23/run_pipeline.sh
build/images/16.snap/golang/1.24/run_pipeline.sh
build/images/16.snap/golang/1.25/run_pipeline.sh
