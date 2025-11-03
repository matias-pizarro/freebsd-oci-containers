# How to test ZFS and sysv IPC annotations
* for a detailed explanation you can refer to [Dave Cottlehuber's tutorial](https://people.freebsd.org/~dch/posts/2025-06-27-oci-zfs/)
* for an extremely complete overview of all aspects of running containers on Freebsd you can refer to [Dave Cottlehuber's documentation page](https://docs.skunkwerks.at/s/fUiAmi4pE#)
* all praise and thanks be heaped on Doug Rabson, Samuel Karp and Alice Sowerby for their work

## Activate OCI hooks
Make sure `/usr/local/etc/containers/containers.conf` specifies the path to at least one  OCI hooks directory and that it is not commented, e.g.:


```shell
hooks_dir = [
  "/usr/local/etc/containers/hooks.d",
]
```

```shell
# execute as root
mkdir -p /usr/local/etc/containers/hooks.d/
```
## Add hooks

### 0. Clone the repo

```shell
git clone git@github.com:matias-pizarro/freebsd-oci-containers.git
cd freebsd-oci-containers
```

### 1. To mount persistent ZFS datasets in any given container
```shell
# execute as root
cp -pf annotations/hooks.d/zfs* /usr/local/etc/containers/hooks.d/
``` 


### 2. To enable sysv IPC in any given container
```shell
# execute as root
cp -pf annotations/hooks.d/sysv* /usr/local/etc/containers/hooks.d/
``` 

## Test with a PostgreSQL container

### 1. Create a persistent ZFS dataset

```shell
# execute as root
zfs create -p \
    -o jailed=on \
    -o mountpoint=/var/db/postgres \
zroot/jailed/postgres
```


### 2. Initialize a PostgreSQL instance

(You can find the Containerfile used to build this image [here](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/freebsd/14.3/postgres/18/Containerfile))

```shell
# pg_major can be any major PostgreSQL version between 13 and 18 (included)
export pg_major=18
export postgres_image="ghcr.io/matias-pizarro/freebsd-oci-containers/freebsd-postgres${pg_major}:14.3"

podman run -it --rm \
	--annotation='sysv=true' \
	--annotation='zfs.dataset=zroot/jailed/postgres' \
	--env POSTGRES_PASSWORD=password \
	${postgres_image} \
	chown -R 770:770 /var/db/postgres
	
podman run -it --rm \
	--annotation='sysv=true' \
	--annotation='zfs.dataset=zroot/jailed/postgres' \
	--env POSTGRES_PASSWORD=password \
	${postgres_image} \
	service postgresql initdb
```

### 3. Run a PostgreSQL server instance

This instance will be available for connections from the host via a socket at `/tmp/postgresql${pg_major}`
```shell
podman run -it --rm \
    --annotation='sysv=true' \
    --volume /tmp/postgresql${pg_major}:/var/run/postgresql \
    --env POSTGRES_PASSWORD=password \
	${postgres_image} \
        postgres -D /var/db/postgres/data${pg_major} \
            -c logging_collector=true \
            -c log_filename=postgres.log \
            -c log_destination=jsonlog \
            -k /var/run/postgresql
```

You can now connect to the server from another command line:

```shell
export pg_major=18
psql -h /tmp/postgresql${pg_major} -U postgres
```
