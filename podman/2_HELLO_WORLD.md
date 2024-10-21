# Hello world!

* Pre-requisite: a working podman set-up (see [Setup podman](1-setup.md))
* [Hello world!](#hello-world)
  * [FreeBSD](#freebsd)
  * [Alpine Linux](#alpine-linux)
* next: [Explore](3-explore.md)


## FreeBSD

### Hello
```bash=
podman run --rm docker.io/dougrabson/hello
```

### Run a command on a container
```bash=
podman run --rm quay.io/dougrabson/freebsd14.1-minimal cat /etc/passwd
```

### Run a console in a container
minimal (35,9 MB) [source](https://github.com/dfr/freebsd-images/blob/main/build-minimal.sh)
```bash=
podman run -it --rm quay.io/dougrabson/freebsd14.1-minimal /bin/sh
```

small (127 MB) [source](https://github.com/dfr/freebsd-images/blob/main/build-small.sh)
```bash=
podman run -it --rm quay.io/dougrabson/freebsd14.1-small /bin/sh
```
OccamBSD (156 MB) [source](https://gitlab.com/bergblume/freebsd-images/-/blob/main/build_image_occambsd.sh)
```bash=
podman run -it --rm quay.io/bergblume/freebsd-occambsd:14.1 /bin/sh
```

large (1.05 GB) [source](https://gitlab.com/bergblume/freebsd-images/-/blob/main/build_image.sh)
```bash=
podman run -it --rm quay.io/bergblume/freebsd:14.1 /bin/sh
```

## Alpine Linux

### Enable Linux
```bash=
sudo sysrc linux_enable=YES
sudo service linux start
```

### Run a command on a container
```bash=
podman run --rm --os=linux docker.io/alpine cat /etc/os-release
```

### Run a console in a container
```bash=
podman run -it --rm --os=linux docker.io/alpine /bin/sh
```
next: [Explore](3-explore.md)
