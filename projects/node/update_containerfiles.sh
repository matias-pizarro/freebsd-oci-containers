#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && cd .. && pwd)

# ${base_dir}/upstreams/node/update.sh

for node_version in 20 22 24; do
    for os_version in 14.3 14.snap 15.snap 16.snap; do
        target_dir="${base_dir}/upstreams/node/${node_version}/freebsd${os_version}"
        rm -rf ${target_dir}
        mkdir -p ${target_dir}
        cp -p ${base_dir}/upstreams/node/Dockerfile-freebsd.template \
            ${target_dir}/Dockerfile
        cp -p ${base_dir}/upstreams/node/docker-entrypoint.sh \
            ${target_dir}/docker-entrypoint.sh
        cp -rp ${base_dir}/flavours/base/files \
            ${target_dir}/
        if [ "${node_version}" == "20" ]; then
            sed -i '' 's|{{ install_archivers_line_1 }}||g' ${target_dir}/Dockerfile
            sed -i '' 's|{{ install_archivers_line_2 }}||g' ${target_dir}/Dockerfile
        else
            sed -i '' 's|{{ install_archivers_line_1 }}|RUN /usr/bin/env pkg install -yr FreeBSD archivers/liblz4 archivers/zstd \\|g' ${target_dir}/Dockerfile
            sed -i '' 's|{{ install_archivers_line_2 }}|    \&\& rm -f /var/cache/pkg/*|g' ${target_dir}/Dockerfile
        fi
        sed -i '' 's|{{ freebsd_version }}|'${os_version}'|g' ${target_dir}/Dockerfile
        sed -i '' 's|{{ node_version }}|'${node_version}'|g' ${target_dir}/Dockerfile
        tempfile=$(mktemp)
        awk '/./ { e=0 } /^$/ { e += 1 } e <= 1' < ${target_dir}/Dockerfile > ${tempfile}
        cat ${tempfile} > ${target_dir}/Dockerfile
    done
done
