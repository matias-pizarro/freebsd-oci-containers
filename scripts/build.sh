#!/usr/bin/env bash

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)
scripts_dir="${base_dir}/scripts"

usage() {
    cat << 'EOF'

build.sh
========

Usage: build.sh [-M <freebsd-major-version>] [-m <freebsd-minor-version>] [-t <container-template>] [-v <container-template-version>] [-h]

Options:
    -M         FreeBSD Major version (default: 14)
    -m         FreeBSD Minor version (default: snap)
    -t         Container template (default: base)
    -v         Container template version (default: <none>)

Examples:
    $ scripts/build.sh

    # Building freebsd-base for FreeBSD 14.3
    #     context: freebsd_containers/freebsd/14.3/base
    #     file   : freebsd_containers/freebsd/14.3/base/Containerfile

    $ scripts/build.sh -M 14 -m 2 -t zfs
    # Building freebsd-zfs for FreeBSD 14.2
    #     context: freebsd_containers/freebsd/14.2/zfs
    #     file   : freebsd_containers/freebsd/14.2/zfs/Containerfile

    $ scripts/build.sh -M 16 -t node -v 20

    # Building freebsd-node20 for FreeBSD 16.snap
    #     context: freebsd_containers/freebsd/16.snap/node/20
    #     file   : freebsd_containers/freebsd/16.snap/node/20/Containerfile

EOF
    exit 1
}

while getopts "M:m:t:v:h" FLAG; do
    case "${FLAG}" in
    M)
        freebsd_major="${OPTARG}"
        ;;
    m)
        freebsd_minor="${OPTARG}"
        ;;
    t)
        template="${OPTARG}"
        ;;
    v)
        template_version="${OPTARG}"
        ;;
    h)
        usage
        ;;
    *)
        usage
        ;;
    esac
done

shift $((OPTIND-1))

freebsd_major="${freebsd_major:-14}"
if [ "${freebsd_major}" == "14" ]; then
    freebsd_minor="${freebsd_minor:-3}"
else
    freebsd_minor="${freebsd_minor:-snap}"
fi
if [ "${freebsd_minor}" == "snap" ]; then
    freebsd_minor_digit="0"
else
    freebsd_minor_digit="${freebsd_minor}"
fi
template="${template:-base}"
template_version="${template_version}"

template_dir="${base_dir}/freebsd/${freebsd_major}.${freebsd_minor}/${template}"
if [ -n "${template_version}" ]; then
    template_dir="${template_dir}/${template_version}"
fi
containerfile="${template_dir}/Containerfile"

# echo ${scripts_dir}
# echo ${template_dir}

echo

case ${template_version:0:1} in
    ''|[0-9])
        version_separator=''
        ;;
    *)
        version_separator='-'
        ;;
esac

echo "# Building freebsd-${template}${version_separator}${template_version} for FreeBSD ${freebsd_major}.${freebsd_minor}"
echo "#     context: ${template_dir}"
echo "#     file   : ${containerfile}"
echo

if [ ! -f "${containerfile}" ]; then
    echo "${containerfile}" does not exist
    exit 1
fi

cd ${template_dir}

podman build \
    --volume /usr/local/sbin/pkg:/bin/pkg \
    --env IGNORE_OSVERSION=yes \
    --env ABI=FreeBSD:${freebsd_major}:$(sysctl -n hw.machine_arch) \
    --env OSVERSION=${freebsd_major}0${freebsd_minor_digit}000 \
    --env VERSION_MINOR=${freebsd_minor_digit} \
    --no-hosts \
    --tag freebsd-${template}${version_separator}${template_version}:${freebsd_major}.${freebsd_minor} \
    --file Containerfile
