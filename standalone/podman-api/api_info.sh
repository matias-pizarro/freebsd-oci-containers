Use the podman api


api_version=$(podman info --debug | grep APIVersion | awk -F ': ' '{print $2}')

# Retrieve general info on the podman service
doas curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${api_version}/libpod/info

# list all containers
doas curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${api_version}/libpod/containers/json?all=true | jq

# inspect a specific container
container_name="pkg_cache.proxy"
doas curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${api_version}/libpod/containers/${container_name}/json | jq

# list all pods
doas curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${api_version}/libpod/pods/json?all=true | jq

# inspect a specific pod
pod_name="foo"
doas curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${api_version}/libpod/pods/${pod_name}/json | jq

You can find context on the podman API at those links:
    - https://docs.podman.io/en/latest/_static/api.html
    - https://www.redhat.com/en/blog/podman-rest-api
