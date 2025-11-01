#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && cd .. && pwd)

${base_dir}/upstreams/postgres/update.sh
