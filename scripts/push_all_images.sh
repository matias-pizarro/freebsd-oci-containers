#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)
scripts_dir="${base_dir}/scripts"

# ${scripts_dir}/build.sh ${scripts_dir}/build.sh \
#     && ${scripts_dir}/build.sh -t zfs \
#     && ${scripts_dir}/build.sh -t node -v 20 \
#     && ${scripts_dir}/build.sh -t node -v 22 \
#     && ${scripts_dir}/build.sh -t node -v 24 \
#     && ${scripts_dir}/build.sh -t postgres -v 13 \
#     && ${scripts_dir}/build.sh -t postgres -v 14 \
#     && ${scripts_dir}/build.sh -t postgres -v 15 \
#     && ${scripts_dir}/build.sh -t postgres -v 16 \
#     && ${scripts_dir}/build.sh -t postgres -v 17 \
#     && ${scripts_dir}/build.sh -t postgres -v 18

mkdir -p ${HOME}/.config/pat
for registry in ghcr.io docker.io quay.io; do
    registry_config_file="${HOME}/.config/pat/${registry}"
    if [ ! -f "${registry_config_file}" ]; do
        echo REGISTRY_USERNAME=\"\" > "${registry_config_file}"
        echo REGISTRY_PAT=\"\" > "${registry_config_file}"
        ee "${registry_config_file}"
    done
    source ${registry_config_file}
    echo "logging into ${registry}"
    echo ${REGISTRY_PAT} | podman login --username ${REGISTRY_USERNAME} --password-stdin ${registry}
    if [ "${registry}" == "ghcr.io" ]; then
        IMAGE_PATH="${registry}/${REGISTRY_USERNAME}/freebsd-oci-containers"
    else
        IMAGE_PATH="${registry}/${REGISTRY_USERNAME}"
    fi
    for project in base zfs node20 node22 node24 postgres13 postgres14 postgres15 postgres16 postgres17 postgres18; do
        echo "Pushing ${project} to ${registry}"
        podman tag localhost/freebsd-${project}:14.3 localhost/freebsd-${project}:latest
        echo "."
        podman tag localhost/freebsd-${project}:14.3 ${IMAGE_PATH}/freebsd-${project}:14.3
        echo "."
        podman tag localhost/freebsd-${project}:latest ${IMAGE_PATH}/freebsd-${project}:latest
        echo "."
        podman push ${IMAGE_PATH}/freebsd-${project}:14.3
        echo "."
        podman push ${IMAGE_PATH}/freebsd-${project}:latest
        echo "."
    done
done
