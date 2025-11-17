#!/bin/sh -e

# see https://people.freebsd.org/~dch/posts/2025-06-27-oci-zfs/

set -o pipefail

INPUT=$(  cat - | tee -a /var/log/oci/sysv.json)
ID=$(     echo $INPUT | jq -r .id || exit 1)
STATUS=$( echo $INPUT | jq -r .status || exit 1)

# if we are in created state, we can proceed
if [ "$STATUS" == "created" ]; then
  /usr/sbin/jail -vm allow.sysvipc=true name=$ID
fi
