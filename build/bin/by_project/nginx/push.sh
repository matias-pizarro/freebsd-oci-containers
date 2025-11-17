#!/usr/bin/env sh
set -Eeuo pipefail

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && cd ../../../.. && pwd)"

build/images/14.3/nginx/stable/push.sh
build/images/14.3/nginx/mainline/push.sh
build/images/14.snap/nginx/stable/push.sh
build/images/14.snap/nginx/mainline/push.sh
build/images/15.0/nginx/stable/push.sh
build/images/15.0/nginx/mainline/push.sh
build/images/15.snap/nginx/stable/push.sh
build/images/15.snap/nginx/mainline/push.sh
build/images/16.snap/nginx/stable/push.sh
build/images/16.snap/nginx/mainline/push.sh
