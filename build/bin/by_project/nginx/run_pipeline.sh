#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/nginx/stable/ci_cd/run_pipeline.sh
build/images/14.3/nginx/mainline/ci_cd/run_pipeline.sh
build/images/14.snap/nginx/stable/ci_cd/run_pipeline.sh
build/images/14.snap/nginx/mainline/ci_cd/run_pipeline.sh
build/images/15.0/nginx/stable/ci_cd/run_pipeline.sh
build/images/15.0/nginx/mainline/ci_cd/run_pipeline.sh
build/images/15.snap/nginx/stable/ci_cd/run_pipeline.sh
build/images/15.snap/nginx/mainline/ci_cd/run_pipeline.sh
build/images/16.snap/nginx/stable/ci_cd/run_pipeline.sh
build/images/16.snap/nginx/mainline/ci_cd/run_pipeline.sh
