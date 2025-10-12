#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)

freebsd_major="${3:-14}"
freebsd_minor="${4:-3}"
template="${1:-base}"
template_version="${2}"
scripts_dir="${base_dir}/scripts"
template_dir="${base_dir}/freebsd/${freebsd_major}.${freebsd_minor}/${template}"
if [ -n "${template_version}" ]; then
  template_dir="${template_dir}/${template_version}"
fi
containerfile="${template_dir}/Containerfile"

# echo ${scripts_dir}
# echo ${template_dir}
cd ${template_dir}

podman build \
  --volume /usr/local/sbin/pkg:/bin/pkg \
  --env IGNORE_OSVERSION=yes \
  --env ABI=FreeBSD:${freebsd_major}:$(sysctl -n hw.machine_arch) \
  --env OSVERSION=${freebsd_major}0${freebsd_minor}000 \
  --no-hosts \
  --tag freebsd-${template}${template_version}:${freebsd_major}.${freebsd_minor} \
  --file Containerfile
