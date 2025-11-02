#!/usr/bin/env sh

base_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)

template="${1:-base}"
freebsd_major="${2:-14}"
freebsd_minor="${3:-3}"
scripts_dir="${base_dir}/scripts"
template_dir="${base_dir}/freebsd_variants/freebsd-${template}/${freebsd_major}.${freebsd_minor}"
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
  --tag freebsd-${template}:${freebsd_major}.${freebsd_minor} \
  --file Containerfile
