#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/15.snap/base/runtime/run_pipeline.sh
build/images/15.snap/zfs/runtime/run_pipeline.sh
build/images/15.snap/golang/1.20/run_pipeline.sh
build/images/15.snap/golang/1.21/run_pipeline.sh
build/images/15.snap/golang/1.22/run_pipeline.sh
build/images/15.snap/golang/1.23/run_pipeline.sh
build/images/15.snap/golang/1.24/run_pipeline.sh
build/images/15.snap/golang/1.25/run_pipeline.sh
build/images/15.snap/nginx/stable/run_pipeline.sh
build/images/15.snap/nginx/mainline/run_pipeline.sh
build/images/15.snap/node/20/run_pipeline.sh
build/images/15.snap/node/22/run_pipeline.sh
build/images/15.snap/node/24/run_pipeline.sh
build/images/15.snap/node/25/run_pipeline.sh
build/images/15.snap/python/3.11/run_pipeline.sh
build/images/15.snap/uv/3.11/run_pipeline.sh
build/images/15.snap/postgres/13/run_pipeline.sh
build/images/15.snap/postgres/14/run_pipeline.sh
build/images/15.snap/postgres/15/run_pipeline.sh
build/images/15.snap/postgres/16/run_pipeline.sh
build/images/15.snap/postgres/17/run_pipeline.sh
build/images/15.snap/postgres/18/run_pipeline.sh
