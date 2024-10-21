freebsd-oci-containers
======================
       ____  __________   ______            __        _                     
      / __ \/ ____/  _/  / ____/___  ____  / /_____ _(_)___  ___  __________
     / / / / /    / /   / /   / __ \/ __ \/ __/ __ `/ / __ \/ _ \/ ___/ ___/
    / /_/ / /____/ /   / /___/ /_/ / / / / /_/ /_/ / / / / /  __/ /  (__  ) 
    \____/\____/___/   \____/\____/_/ /_/\__/\__,_/_/_/ /_/\___/_/  /____/  
                                                                            

A repository of Podman/Docker images for FreeBSD

<br>

# TL:DR; You will find here images of your favourite services to experiment with Jail-based OCI containers on FreeBSD
<br>
<br>


* [Setting up podman](podman/1_SETUP.md) (split into its own section)
![Screenshot_20241016_093723](https://github.com/user-attachments/assets/649ebcad-47ad-405a-add2-211f5010c6f3)

* [Currently available blueprints](#currently-available-blueprints)
* [Project intent](#project-intent)
* [Quickstart](#quickstart): build/modify images
* [Podman API](#podman-api)
* [Target images](#target-images)
* [Roadmap](#roadmap)

# Currently available blueprints
```
* base-headless-system                0.2.0      provide a base FreeBSD environment to run headless services 
* base-linux-alpine-headless-system   0.1.0      provide a base Linux Alpine environment to run headless services 
* base-system                         0.2.0      provide a base user-login friendly FreeBSD environment
* nginx-base                          0.2.0      base nginx instance to be used as base for http server needs
* nginx-podman-api                    0.1.0      serve Poudriere packages and build stats
* nginx-poudriere                     0.1.0      serve Poudriere packages and build stats
* pulumi-dev                          pending    provide an environment to work on Pulumi
```

# Project intent

* Test FreeBSD OCI cointainers in the context of real-life use cases and scenario, very much in the spirit of FreeBSD's ports+pkg approach:
    * working image configurations that can be built by anyone
    * these can be used as blueprints for further customizations and use cases
    * a registry of built images
* Main types of use cases are:
    * service jails
    * sandboxed work environments
    * composed multi-container applications, such as:
    * pipelines and computation primitives for data processing / data science / data engineering / AI use cases
        * Immich
        * Mailcow-jailed
        * Paperless-ng
* the project will be submitted to become part of the port collections
* Other test targets:
    * CI/CD pipelines / Ansible / Python API / Terraform / Pulumi / Kubernetes
* An area of particular interest is the [Podman API](#podman_api) and the pod paradigm

# Quickstart

## Clone the repo
```bash=
git clone git@github.com:matias-pizarro/freebsd-oci-containers.git
cd freebsd-oci-containers
```

## Build an image, for instance nginx-poudriere
```bash=
./containerfiles/nginx-poudriere/build.sh
```

## Launch a container using a pre-defined config that can be used as a starting point for further customization 
```bash=
./containerfiles/nginx-poudriere/run.sh
```

## Build all images
```bash=
./bin/rebuild_all_images.sh
```

## Print image description
```bash=
./containerfiles/nginx-poudriere/description

name:               nginx-poudriere
purpose:            serve Poudriere packages and build stats
status:             active
build args:         none
runtime env vars:   NGINX_PORT (defaults to 80)
exposed ports:      NGINX_PORT
services:           pkg server
                    Poudriere web ui
stdout:             /var/log/nginx/error.log
other logs:         /var/log/nginx/access.log
mounts:             /usr/local/poudriere/data:/usr/local/poudriere/data
                    /usr/local/poudriere/data/packages:/usr/local/poudriere/data/packages
                    /usr/local/poudriere/data/logs/bulk:/usr/local/poudriere/data/logs/bulk
                    /usr/local/share/poudriere/html:/usr/local/share/poudriere/html
readiness:          TBD
heartbeat:          HTTP 200 OK! at /heartbeat
```

# Launch all containers (for testing purposes)
```bash=
bin/run_all_containers.sh
```

# Podman API

Once Podman is installed you can optionally run the podman-service, which I highly recommend. This provides a fully functional REST API that can be used to get information but also start and manage the lifecycle of containers and jails

API reference:
  * https://docs.podman.io/en/stable/_static/api.html
  * https://www.redhat.com/en/blog/podman-rest-api


to launch the service for testing purposes:
```
service podman-service onestart
```

to persist this after reboot:
```
sysrc podman_service_enable="YES"
service podman-service start
```

You can then access the API from the host (make sure you run this as root or have sufficient privileges):
```
API_VERSION=$(podman info --debug | grep APIVersion | awk -F ': ' '{print $2}')
curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${API_VERSION}/libpod/info | jq
```

Finding out information about my running nginx-poudriere jail:
```
curl -vs --unix-socket /var/run/podman/podman.sock \
    -H content-type:application/json \
    http://d/v${API_VERSION}/libpod/containers/nginx-poudriere/json | jq
```

You can also use the [nginx-podman-api](#containerfiles/nginx-podman-api) blueprint and resulting image to serve the Podman REST API via nginx both on the host but also interistingly, for remote access. This is not secured so to be used for testing purposes or in an isolated environment. At some point we will provide one or more options to run this securely.

Build the image
```bash=
./containerfiles/nginx-podman-api/build.sh
```

Run the image
```bash=
./containerfiles/nginx-podman-api/run.sh
```

If you are running this locally, retrieve service specs:
```bash=
JAIL_NAME="nginx-podman-api"
NGINX_PORT=${NGINX_PORT:-8888}
JAIL_IP=$(podman exec -it ${JAIL_NAME} ifconfig eth0 inet | grep inet | awk '{print $2}')
```

Now you can access the remote API via the podman CLI:
```bash=
podman --remote --url tcp://${JAIL_IP}:${NGINX_PORT} images
```

Or an http request via curl or in your favourite browser:
```bash=
curl -v http://${JAIL_IP}:${NGINX_PORT}/v${API_VERSION}/libpod/info | jq
curl -v http://${JAIL_IP}:${NGINX_PORT}/v${API_VERSION}/libpod/containers/json | jq
curl -v http://${JAIL_IP}:${NGINX_PORT}/v${API_VERSION}/libpod/containers/${JAIL_NAME}/json | jq
```

*Coming soon: launching containers and pods via the API*

# Target images
*Coming soon*
```


```

# Roadmap
*Coming soon*
```


```
