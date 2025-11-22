#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/base/runtime/ci_cd/run_pipeline.sh
build/images/14.3/zfs/runtime/ci_cd/run_pipeline.sh
build/images/14.3/golang/1.20/ci_cd/run_pipeline.sh
build/images/14.3/golang/1.21/ci_cd/run_pipeline.sh
build/images/14.3/golang/1.22/ci_cd/run_pipeline.sh
build/images/14.3/golang/1.23/ci_cd/run_pipeline.sh
build/images/14.3/golang/1.24/ci_cd/run_pipeline.sh
build/images/14.3/golang/1.25/ci_cd/run_pipeline.sh
build/images/14.3/nginx/stable/ci_cd/run_pipeline.sh
build/images/14.3/nginx/mainline/ci_cd/run_pipeline.sh
build/images/14.3/node/20/ci_cd/run_pipeline.sh
build/images/14.3/node/22/ci_cd/run_pipeline.sh
build/images/14.3/node/24/ci_cd/run_pipeline.sh
build/images/14.3/node/25/ci_cd/run_pipeline.sh
build/images/14.3/python/3.11/ci_cd/run_pipeline.sh
build/images/14.3/uv/3.11/ci_cd/run_pipeline.sh
build/images/14.3/postgres/13/ci_cd/run_pipeline.sh
build/images/14.3/postgres/14/ci_cd/run_pipeline.sh
build/images/14.3/postgres/15/ci_cd/run_pipeline.sh
build/images/14.3/postgres/16/ci_cd/run_pipeline.sh
build/images/14.3/postgres/17/ci_cd/run_pipeline.sh
build/images/14.3/postgres/18/ci_cd/run_pipeline.sh
