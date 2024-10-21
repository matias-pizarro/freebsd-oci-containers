#!/bin/sh

IMAGE=localhost/nginx-poudriere
JAIL_NAME=nginx-poudriere
NGINX_PORT=${NGINX_PORT:-80}
JAIL_ID=$( \
    podman run --name ${JAIL_NAME} \
    --detach --rm --replace \
    --restart=always \
    --env NGINX_PORT=${NGINX_PORT} \
    --volume /usr/local/poudriere/data:/usr/local/poudriere/data \
    --volume /usr/local/poudriere/data/packages:/usr/local/poudriere/data/packages \
    --volume /usr/local/poudriere/data/logs/bulk:/usr/local/poudriere/data/logs/bulk \
    --volume /usr/local/share/poudriere/html:/usr/local/share/poudriere/html \
    ${IMAGE}
)
JAIL_IP=$(podman exec -it ${JAIL_NAME} ifconfig eth0 inet | grep inet | awk '{print $2}')
JAIL_ROOT=$(podman mount ${JAIL_NAME})

echo "################################################################################################################"
echo "The following can be pasted in your console to expose these values as environment variables:"
echo ""
echo "http://${JAIL_IP}:${NGINX_PORT}/"
echo "URL=http://${JAIL_IP}:${NGINX_PORT}/"
echo ""
echo "JAIL_IP=${JAIL_IP}"
echo "JAIL_NAME=${JAIL_NAME}"
echo "JAIL_ID=${JAIL_ID}"
echo "JAIL_ROOT=${JAIL_ROOT}"
echo ""
echo "################################################################################################################"
