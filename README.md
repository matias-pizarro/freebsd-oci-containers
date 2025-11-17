freebsd-oci-containers
======================

## View Containerfiles and  [documentation](https://matias-pizarro.github.io/freebsd-oci-containers/images/) at [https://matias-pizarro.github.io/freebsd-oci-containers/images/](https://matias-pizarro.github.io/freebsd-oci-containers/images/)

Centralize a repository of image definitions that should be as functionally similar as the official docker images as possible.

The main goal is many-fold:
* to provide a set of standardized base FreeBSD implementations
* to make those implementations drop-in replacements for solutions designed for other OS
* provide the ground work to get those FreeBSD variants adopted as part of each official project, e.g. docker-node, docker-postgres etc.
* support an automated CI/CD pipeline that feeds a matrix of images into ghcr.io, Docker Hub and quay.io
* support/document for each project how to build, test, run and customize each image

n projects x 6 versions x 3 architectures

### Available projects:

* [FreeBSD-base](https://matias-pizarro.github.io/freebsd-oci-containers/images/base/) -> available

* [FreeBSD-zfs](https://matias-pizarro.github.io/freebsd-oci-containers/images/zfs/) (supports annotation to mount persistent ZFS datasets)

* [Postgres](https://matias-pizarro.github.io/freebsd-oci-containers/images/postgres/) (supports annotation to allow SysV IPC)

* [Node.js](https://matias-pizarro.github.io/freebsd-oci-containers/images/node/)

* [Python](https://matias-pizarro.github.io/freebsd-oci-containers/images/python/)

* [uv](https://matias-pizarro.github.io/freebsd-oci-containers/images/uv/)

* [Nginx](https://matias-pizarro.github.io/freebsd-oci-containers/images/nginx/)

* [Go](https://matias-pizarro.github.io/freebsd-oci-containers/images/golang/)

* nginx + poudriere UI -> available

* nginx + podman-api -> available

### Coming soon

* pulumi

* redis

* valkey

* Ray

* poudriere

* CouchDB

* MongoDB

* Immich

* GitLab

* MailCow

* Airflow

* Paperless-ng

* SourceHut

* NextCloud

* MinIO

* HedgeDoc

* Excalidraw

* Ollama

* n8n

* PHP

* MariaDB

* Wireguard + ProCustodibus

* Controllers

* fastapi

* grafana



etc.


Target versions:

* 14.3

* 15.0

* 14.snap

* 15.snap

* 16.snap


Target architectures:

* amd64

* aarch64

* riscv64




https://github.com/matias-pizarro?tab=packages

https://hub.docker.com/u/matiaspizarro

https://quay.io/user/matiaspizarro/

https://download.freebsd.org/ftp/releases/OCI-IMAGES/

https://hub.docker.com/u/freebsd

https://github.com/orgs/freebsd/packages

https://git.sr.ht/~dch/

https://hub.docker.com/u/dougrabson

https://gitlab.com/bergblume
