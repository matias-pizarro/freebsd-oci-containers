#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && cd .. && pwd)

for python_minor_version in 10 11 12 13 14; do
    for os_version in 14.3 14.snap 15.snap 16.snap; do
        target_dir="${base_dir}/upstreams/uv/3.${python_minor_version}/freebsd${os_version}"
        rm -rf ${target_dir}
        mkdir -p ${target_dir}
        cp -p ${base_dir}/upstreams/uv/Dockerfile-freebsd.template \
            ${target_dir}/Dockerfile
        sed -i '' 's|{{ freebsd_version }}|'${os_version}'|g' ${target_dir}/Dockerfile
        sed -i '' 's|{{ python_minor_version }}|'${python_minor_version}'|g' ${target_dir}/Dockerfile
        tempfile=$(mktemp)
        awk '/./ { e=0 } /^$/ { e += 1 } e <= 1' < ${target_dir}/Dockerfile > ${tempfile}
        cat ${tempfile} > ${target_dir}/Dockerfile
    done
done
