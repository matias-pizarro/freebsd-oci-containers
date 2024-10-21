#!/bin/sh

IMAGE=localhost/nginx-podman-api
JAIL_NAME=nginx-podman-api
NGINX_PORT=${NGINX_PORT:-8888}
JAIL_ID=$( \
    podman run --name ${JAIL_NAME} \
    --detach --rm --replace \
    --env NGINX_PORT=${NGINX_PORT} \
    --volume /var/run/podman:/var/run/podman \
    ${IMAGE}
)
JAIL_IP=$(podman exec -it ${JAIL_NAME} ifconfig eth0 inet | grep inet | awk '{print $2}')
JAIL_ROOT=$(podman mount ${JAIL_NAME})
API_VERSION=$(podman info --debug | grep APIVersion | awk -F ': ' '{print $2}')

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
echo "API"
echo "==="
echo ""
echo "references:"
echo "  https://docs.podman.io/en/stable/_static/api.html"
echo "  https://www.redhat.com/en/blog/podman-rest-api"
echo ""
echo "You can access the podman api in the following fashions:"
echo "podman --remote --url tcp://${JAIL_IP}:${NGINX_PORT} images"
echo ""
echo "curl -v http://${JAIL_IP}:${NGINX_PORT}/v${API_VERSION}/libpod/info | jq"
echo "curl -v http://${JAIL_IP}:${NGINX_PORT}/v${API_VERSION}/libpod/containers/json | jq"
echo "curl -v http://${JAIL_IP}:${NGINX_PORT}/v${API_VERSION}/libpod/containers/${JAIL_NAME}/json | jq"
echo ""
echo "# If you are running the podman api service you can look this pod up"
echo "# You will need to run this as root or with sudo/doas"
echo "curl -vs --unix-socket /var/run/podman/podman.sock \\"
echo "    -H content-type:application/json \\"
echo "    http://d/v${API_VERSION}/libpod/containers/${JAIL_NAME}/json | jq"
echo ""

echo "################################################################################################################"
