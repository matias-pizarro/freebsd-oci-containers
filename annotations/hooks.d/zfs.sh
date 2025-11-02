#!/bin/sh -e

# see https://people.freebsd.org/~dch/posts/2025-06-27-oci-zfs/

set -o pipefail

INPUT=$(  cat - | tee -a /var/log/oci/zfs.json)
ID=$(     echo $INPUT | jq -r .id || exit 1)
STATUS=$( echo $INPUT | jq -r .status || exit 1)
DATASET=$(echo $INPUT | jq -r '.annotations."zfs.dataset"')

# echo $INPUT >> /tmp/debug
# echo $STATUS >> /tmp/debug
# echo $DATASET >> /tmp/debug
# echo $(date +"%Y-%m-%d %H:%M:%S") >> /tmp/debug

# if the dataset doesn't actually exist, bail
/sbin/zfs list -Ho name ${DATASET} || exit 1

# if we are in created state, we can proceed
if [ "$STATUS" == "created" ]; then
  /usr/sbin/jail -vm name=$ID allow.mount=1 allow.mount.zfs=1 allow.mount enforce_statfs=1
  /sbin/zfs jail $ID ${DATASET}
  /usr/sbin/jexec $ID /sbin/zfs mount -a
fi

# if status = stopped, loop over mounted datasets
if [ "$STATUS" == "stopped" ]; then
  for ds in $(/sbin/zfs list -Ho name -r ${DATASET}); do
    /sbin/umount -f ${ds}
  done
fi

