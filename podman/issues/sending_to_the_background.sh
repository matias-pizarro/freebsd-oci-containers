#!/bin/sh

# this works
podman run --rm --name nginx-base -p 8080:80 localhost/nginx
# send the service to the background
ctrl+z
disown
# but then stopping and restarting the container doesn't work as expected
podman stop nginx-base
podman run --rm --name nginx-base -p 8080:80 localhost/nginx
Error: creating container storage: the container name "nginx-base" is already in use by xxx. You have to remove that container to be able to reuse that name: that name is already in use, or use --replace to instruct Podman to do so.
# replacing the container by name works
podman run --replace --rm --name nginx-base -p 8080:80 localhost/nginx
# you cannot ctrl+C the tail
ctrl+C
# ... but you can stop it from another shell
podman stop nginx-base


# this works
podman run --rm --name nginx-base -p 8080:80 localhost/nginx
# send the service to the background
ctrl+z
# recall it
fg
# but if you try to send the service to the background again the prompt hangs
ctrl+z
# prompt 
