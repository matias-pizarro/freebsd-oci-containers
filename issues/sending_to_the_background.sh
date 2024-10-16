#!/bin/sh

podman run --rm --name base-nginx -p 8080:80 localhost/nginx

# send the service to the background
ctrl+z

# recall it
fg

# send the service to the background for good
# it will stay alive if the shell is closed
ctrl+z
disown
