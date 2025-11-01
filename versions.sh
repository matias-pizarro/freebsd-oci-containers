#!/usr/bin/env bash
set -Eeuo pipefail
shopt -s nullglob

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
upstreams_dir="${base_dir}/upstreams"
mkdir -p "${upstreams_dir}"
flavours_dir="${base_dir}/flavours"
mkdir -p "${flavours_dir}"
projects_dir="${base_dir}/projects"
mkdir -p "${projects_dir}"

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

# os_major_versions=( "$@" )
# if [ ${#os_major_versions[@]} -eq 0 ]; then
#     os_major_versions=( */ )
#     json='{}'
# else
#     json="$(< os_major_versions.json)"
# fi
# os_major_versions=( "${os_major_versions[@]%/}" )

# echo "aaa${os_major_versions[1]}bbb"
# echo "aaa${os_major_versions[@]}bbb"

# for b in ${os_major_versions[@]}; do
#     echo ${b}
# done

# for b in ${os_major_versions}; do
#     echo ${b}
# done

# echo $json
# add annotations = ["sysv=true"]

json="$(< versions.json)"
os="freebsd"
os_dir="${base_dir}/${os}"
mkdir -p "${os_dir}"
os_major_versions=( "$@" )
os_major_versions=($(jq <<<"$json" -r 'keys[]'))

project_updated=()
for os_major_version in "${os_major_versions[@]}"; do
    export os_major_version
    branches=( "$@" )

    branches=( $( \
        jq <<<"$json" -rc \
            --arg os_major_version "${os_major_version}" \
            '.[$os_major_version].branches | keys | @sh' \
        | tr -d "'" \
    ) )
    projects=( $( \
        jq <<<"$json" -rc \
            --arg os_major_version "${os_major_version}" \
            '.[$os_major_version].projects | keys | @sh' \
        | tr -d "'" \
    ) )
    for branch in "${branches[@]}"; do
        os_version="${os_major_version}.${branch/snapshot/snap}"
        echo ${os_version}
        os_version_dir="${os_dir}/${os_version}"
        for flavour in base zfs; do
            flavour_dir="${flavours_dir}/${flavour}"
            os_flavour_dir="${os_version_dir}/${flavour}"
            rsync -avz ${flavour_dir} ${os_version_dir}
            sed -i '' 's|{{ freebsd_version }}|'${os_version}'|g' ${os_flavour_dir}/Containerfile
        done
        for project in "${projects[@]}"; do
            project_template_dir="${projects_dir}/${project}"
            project_update_script="${project_template_dir}/update_containerfiles.sh"
            mkdir -p ${project_template_dir}/files
            project_versions=( $( \
                jq <<<"$json" -rc \
                    --arg os_major_version "${os_major_version}" \
                    --arg project "${project}" \
                    '.[$os_major_version].projects[$project].versions | @sh' \
                | tr -d "'"\
            ) )
            arches=( $( \
                jq <<<"$json" -rc \
                    --arg os_major_version "${os_major_version}" \
                    --arg project "${project}" \
                    '.[$os_major_version].projects[$project].arches | @sh' \
                | tr -d "'"\
            ) )
            upstream=( $( \
                jq <<<"$json" -rc \
                    --arg os_major_version "${os_major_version}" \
                    --arg project "${project}" \
                    '.[$os_major_version].projects[$project].upstreams["freebsd"]' \
                | tr -d "'"\
            ) )
            echo "    - ${project}"
            project_dir="${os_version_dir}/${project}"
            mkdir -p "${project_dir}"
            upstream_project_dir="${upstreams_dir}/${project}"
            if [ ! -f "${upstream_project_dir}/.git/config" ]; then
                echo "creating ${upstream_project_dir}"
                git clone --branch freebsd -- ${upstream} ${upstream_project_dir}
            fi
            if [[ ! "${project_updated[@]}" =~ "${project}" ]]; then
                if [ -f "${project_update_script}" -a -x "${project_update_script}" ]; then
                    sh -c "exec ${project_update_script}"
                else
                   echo "          ${project_update_script} is not executable"
                fi
                project_updated+=(${project})
            fi
            for project_version in "${project_versions[@]}"; do
                echo "        - ${project_version}"
                echo "          mkdir -p ${project_dir}/${project_version}"
                project_version_dir="${project_dir}/${project_version}"
                mkdir -p "${project_version_dir}"
                upstream_project_version_dir="${upstreams_dir}/${project}/${project_version}/${os}${os_version}"
                echo "              ${upstream_project_version_dir}"
                for arch in "${arches[@]}"; do
                    echo "            - ${arch}"
                done
                rsync -avz ${upstream_project_version_dir}/ ${project_version_dir}
                echo rsync -avz ${upstream_project_version_dir}/ ${project_version_dir}
                rsync -avz ${project_template_dir}/files/ ${project_version_dir}/
                mv ${project_version_dir}/Dockerfile ${project_version_dir}/Containerfile
            done
        done
    done
done