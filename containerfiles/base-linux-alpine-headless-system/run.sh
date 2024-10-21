#!/bin/sh

IMAGE=localhost/base-linux-alpine-headless-system
JAIL_NAME=linux-alpine-headless
JAIL_ID=$( \
    podman run --name ${JAIL_NAME} \
    --detach --rm --replace \
    --os=linux \
    ${IMAGE}
)
JAIL_IP=$(podman exec -it ${JAIL_NAME} ip address 2>& 1 | grep inet | grep eth0 | awk '{print $2}' | awk -F '/' '{print $1}')
JAIL_ROOT=$(podman mount ${JAIL_NAME})

echo "################################################################################################################"
echo "The following can be pasted in your console to expose these values as environment variables:"
echo ""
echo "JAIL_IP=${JAIL_IP}"
echo "JAIL_NAME=${JAIL_NAME}"
echo "JAIL_ID=${JAIL_ID}"
echo "JAIL_ROOT=${JAIL_ROOT}"
echo ""
echo "################################################################################################################"
