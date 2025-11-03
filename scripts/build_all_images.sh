#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)
scripts_dir="${base_dir}/scripts"

${scripts_dir}/build.sh ${scripts_dir}/build.sh \
    && ${scripts_dir}/build.sh -t zfs \
    && ${scripts_dir}/build.sh -t node -v 20 \
    && ${scripts_dir}/build.sh -t node -v 22 \
    && ${scripts_dir}/build.sh -t node -v 24 \
    && ${scripts_dir}/build.sh -t node -v 25 \
    && ${scripts_dir}/build.sh -t postgres -v 13 \
    && ${scripts_dir}/build.sh -t postgres -v 14 \
    && ${scripts_dir}/build.sh -t postgres -v 15 \
    && ${scripts_dir}/build.sh -t postgres -v 16 \
    && ${scripts_dir}/build.sh -t postgres -v 17 \
    && ${scripts_dir}/build.sh -t postgres -v 18 \
    && ${scripts_dir}/build.sh -t python -v 3.11 \
    && ${scripts_dir}/build.sh -t uv -v 3.11
