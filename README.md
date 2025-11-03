freebsd-oci-containers
======================

Centralize a repository of image definitions that should be as functionally similar as the official docker images as possible.

The main goal is many-fold:
* to provide a set of standardized base FreeBSD implementations
* to make those implementations drop-in replacements for solutions designed for other OS
* provide the ground work to get those FreeBSD variants adopted as part of each official project, e.g. docker-node, docker-postgres etc.
* support an automated CI/CD pipeline that feeds a matrix of images into ghcr.io, Docker Hub and quay.io
* support/document for each project how to build, test, run and customize each image

n projects x 6 versions x 3 architectures

Target projects:

* freebsd-base -> available

* freebsd-zfs -> available (supports annotation to mount persistent ZFS datasets)

* freebsd-postgres [13, 14, 15, 16, 17, 18] -> available (supports annotation to run sysv IPC-enabled containers)

* freebsd-node [20, 22, 24, 25] -> available

* freebsd-python [3.11] -> available [3.10, 3.12, 3.13, 3.14] -> in progress

* freebsd-uv [3.10, 3.11, 3.12, 3.13, 3.14]

* freebsd-nginx

* freebsd-go

* freebsd-pulumi

* freebsd-redis

* freebsd-celery

* freebsd-poudriere

etc.


Target versions:

* 14.2

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
