#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/base/runtime/run_pipeline.sh
build/images/14.3/zfs/runtime/run_pipeline.sh
build/images/14.3/golang/1.20/run_pipeline.sh
build/images/14.3/golang/1.21/run_pipeline.sh
build/images/14.3/golang/1.22/run_pipeline.sh
build/images/14.3/golang/1.23/run_pipeline.sh
build/images/14.3/golang/1.24/run_pipeline.sh
build/images/14.3/golang/1.25/run_pipeline.sh
build/images/14.3/nginx/stable/run_pipeline.sh
build/images/14.3/nginx/mainline/run_pipeline.sh
build/images/14.3/node/20/run_pipeline.sh
build/images/14.3/node/22/run_pipeline.sh
build/images/14.3/node/24/run_pipeline.sh
build/images/14.3/node/25/run_pipeline.sh
build/images/14.3/python/3.11/run_pipeline.sh
build/images/14.3/uv/3.11/run_pipeline.sh
build/images/14.3/postgres/13/run_pipeline.sh
build/images/14.3/postgres/14/run_pipeline.sh
build/images/14.3/postgres/15/run_pipeline.sh
build/images/14.3/postgres/16/run_pipeline.sh
build/images/14.3/postgres/17/run_pipeline.sh
build/images/14.3/postgres/18/run_pipeline.sh
