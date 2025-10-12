#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)
scripts_dir="${base_dir}/scripts"

base_version="14.3"
base_version_dir="${base_dir}/freebsd/${base_version}"
base_image_uri="$(cat ${base_version_dir}/base_image)"
echo ${base_image_uri}

cd ${base_version_dir}
for elements in $(find . -name "Containerfile"); do
    template="$(echo ${elements} | awk -F '/' '{print $2}')"
    next="$(echo ${elements} | awk -F '/' '{print $3}')"
    if [ "${next}" == "Containerfile" ]; then
        version=""
        template_parent_dir=""
        template_dir="${template}"
    else
        version="${next}"
        template_parent_dir="/${template}"
        template_dir="${template}/${version}"
    fi
    base_template_dir="${base_version_dir}/${template_dir}"
    for target_version in 14.snap 15.snap 16.snap; do
        target_version_dir="${base_dir}/freebsd/${target_version}"
        target_template_parent_dir="${target_version_dir}${template_parent_dir}"
        target_template_dir="${target_version_dir}/${template_dir}"
        mkdir -p "${target_version_dir}${template_parent_dir}"
        rsync -avz "${base_template_dir}" "${target_template_parent_dir}"
        target_base_image_uri="$(cat ${target_version_dir}/base_image)"
        sed 's|'"${base_image_uri}"'|'"${target_base_image_uri}"'|g' "${base_template_dir}/Containerfile" > "${target_template_dir}/Containerfile"
    done
done
