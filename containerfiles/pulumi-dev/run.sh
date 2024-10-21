#!/bin/sh

IMAGE=localhost/pulumi-dev
JAIL_NAME=pulumi-dev
JAIL_ID=$( \
    podman run --name ${JAIL_NAME} \
    --detach --rm --replace \
    ${IMAGE}
)
JAIL_IP=$(podman exec -it ${JAIL_NAME} ifconfig eth0 inet | grep inet | awk '{print $2}')
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