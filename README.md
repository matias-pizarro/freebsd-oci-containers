containers
==========
                        __        _                         
      _________  ____  / /_____ _(_)___  ___  __________    
     / ___/ __ \/ __ \/ __/ __ `/ / __ \/ _ \/ ___/ ___/    
    / /__/ /_/ / / / / /_/ /_/ / / / / /  __/ /  (__  )     
    \___/\____/_/ /_/\__/\__,_/_/_/ /_/\___/_/  /____/      
                                                            

A repository of Podman/Docker images for FreeBSD

* [Setup Podman](#setup-podman)
* [Hello world!](#hello-world)
  * [FreeBSD](#freebsd)
  * [Alpine Linux](#alpine-linux)
* [Build the images](#build-the-images)
* [Experiment](#experiment)

# [Setup podman](1_SETUP.md)
![Screenshot_20241016_093723](https://github.com/user-attachments/assets/649ebcad-47ad-405a-add2-211f5010c6f3)

# Hello world!

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

# Build the images
```bash=
git clone git@github.com:matias-pizarro/containers.git
cd containers
./rebuild_all_images.sh
```

# Build a single image. e.g. nginx
```bash=
./nginx/build.sh
```

# Experiment

launch the base-nginx service
  * stateless, tailing the error log in the foreground
  * when stopped, state is destroyed
```bash=
podman run --rm --name base-nginx -p 8080:80 localhost/nginx
```

send the service to the background
```bash=
ctrl+z
```

stop it
```bash=
podman stop base-nginx
```

launch the base-nginx service
  * stateless, in the background
```bash=
JAIL_ID=$(podman run -d --rm --name base-nginx -p 8080:80 localhost/nginx)
echo ${JAIL_ID}
```
```
3197cf742d9317413b2fdc677b4ff434b298b4c8f057958a6b118baa1e9ddcd7
```
```bash=
jls
```
```
   JID  IP Address      Hostname                      Path
    27                  3197cf742d93                  /var/db/containers/storage/zfs/graph/3ff0b2a9fb4c44f88dd153c580dbc02b1e189
```


launch the base-nginx service
  * state is preserved across start/stop cycles
  * the new container replaces the running one
```bash=
podman run --replace -d --name base-nginx -p 8080:80 localhost/nginx
podman exec -it base-nginx /bin/sh
```
In the container
```bash=
echo 2 > /root/test.txt
```
On the host
```bash=
podman exec -it base-nginx cat /root/test.txt
```
```
2
```
```bash=
podman stop base-nginx
podman start base-nginx
podman exec -it base-nginx cat /root/test.txt
```
```
2
```

tail the error log
```bash=
podman logs -f base-nginx
```
or
```bash=
podman exec -it base-nginx tail -F /var/log/nginx/error.log
```

tail the access log
```bash=
podman exec -it base-nginx tail -F /var/log/nginx/access.log
```

see the list of running containers
```bash=
podman ps
```
```
CONTAINER ID  IMAGE                   COMMAND     CREATED         STATUS         PORTS                 NAMES
3197cf742d93  localhost/nginx:latest              26 minutes ago  Up 24 minutes  0.0.0.0:8080->80/tcp  base-nginx
```
or
```bash=
jls
```
```
   JID  IP Address  Hostname      Path
    27              3197cf742d93  /var/db/containers/storage/zfs/graph/3ff0b2a9fb4c44f88dd153c580dbc02b1e189
```

get the ip of a running container
```bash=
IP=$(podman exec -it base-nginx ifconfig eth0 inet | grep inet | awk '{print $2}')
echo ${IP}
```

```
10.88.0.25
```

inspect the container
```bash=
podman inspect base-nginx
JAIL_ID=$(podman inspect base-nginx | grep Id | awk -F '"' '{print $4}')
JAIL_IP=$(podman inspect base-nginx | grep -m 1 IPAddress | awk -F '"' '{print $4}')
```

Check that the nginx
```bash=
curl -v ${JAIL_IP}
```

```html=
*   Trying 10.88.0.27:80...
* Connected to 10.88.0.27 (10.88.0.27) port 80
* using HTTP/1.x
> GET / HTTP/1.1
> Host: 10.88.0.27
> User-Agent: curl/8.10.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Server: nginx/1.26.2
< Date: Wed, 16 Oct 2024 13:38:02 GMT
< Content-Type: text/html
< Content-Length: 615
< Last-Modified: Mon, 12 Aug 2024 14:28:31 GMT
< Connection: keep-alive
< ETag: "66ba1c0f-267"
< Accept-Ranges: bytes
< 
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
* Connection #0 to host 10.88.0.27 left intact
```

trigger an nginx reload 
```bash=
podman exec -it base-nginx service nginx reload
```
or
```bash=
jexec ${JAIL_ID} service nginx reload
```

get the jail's base filesystem mountpoint

```bash=
JAIL_ROOT=$(podman mount base-nginx)
ls ${JAIL_ROOT}
```

```
total 114
dr-xr-xr-x  18 root wheel   20 Oct 16 10:33 .
dr-xr-xr-x  28 root wheel   28 Oct 16 15:32 ..
-rw-r--r--   2 root wheel  495 Sep 26 01:00 .profile
-r--r--r--   1 root wheel 6109 Sep 26 01:00 COPYRIGHT
drwxr-xr-x   2 root wheel   45 Sep 26 01:00 bin
drwxr-xr-x  12 root wheel   12 Sep 26 01:00 boot
dr-xr-xr-x  12 root wheel  512 Oct 16 15:32 dev
drwxr-xr-x  30 root wheel   88 Oct 16 15:32 etc
drwxr-xr-x   4 root wheel   52 Sep 26 01:00 lib
drwxr-xr-x   3 root wheel    4 Sep 26 01:00 libexec
drwxr-xr-x   2 root wheel    2 Sep 26 01:00 media
drwxr-xr-x   2 root wheel    2 Sep 26 01:00 mnt
drwxr-xr-x   2 root wheel    2 Sep 26 01:00 net
dr-xr-xr-x   2 root wheel    2 Sep 26 01:00 proc
drwxr-xr-x   2 root wheel    2 Sep 26 01:00 rescue
drwxr-x---   2 root wheel    5 Sep 26 01:00 root
drwxr-xr-x   2 root wheel  102 Sep 26 01:00 sbin
drwxrwxrwx   2 root wheel    2 Sep 26 01:00 tmp
drwxr-xr-x  14 root wheel   14 Sep 26 01:00 usr
drwxr-xr-x  24 root wheel   24 Sep 26 01:00 var
```

see a stream of container stats
```bash=
podman stats
```

```
ID            NAME        CPU %       MEM USAGE / LIMIT  MEM %       NET IO             BLOCK IO    PIDS        CPU TIME    AVG CPU %
c7674a02b085  base-nginx  0.00%       0B / 66.22GB       0.00%       1.278kB / 3.459kB  0B / 0B     0           0s          0.00%
```

```bash=
podman generate kube base-nginx 
```

```yaml=
# Save the output of this file and use kubectl create -f to import
# Save the output of this file and use kubectl create -f to import
# it into Kubernetes.
#
# Created with podman-5.1.1

# NOTE: If you generated this yaml from an unprivileged and rootless podman container on an SELinux
# enabled system, check the podman generate kube man page for steps to follow to ensure that your pod/container
# has the right permissions to access the volumes added.
---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2024-10-16T07:49:23Z"
  labels:
    app: base-nginx-pod
  name: base-nginx-pod
spec:
  containers:
  - image: localhost/nginx:latest
    name: base-nginx
    ports:
    - containerPort: 80
      hostPort: 8080
    volumeMounts:
    - mountPath: /var/cache/pkg
      name: 718489f17ab8ad11e495a6d6fa94b7a0cbede567c4e8d503990b305016423975-pvc
  volumes:
  - name: 718489f17ab8ad11e495a6d6fa94b7a0cbede567c4e8d503990b305016423975-pvc
    persistentVolumeClaim:
      claimName: 718489f17ab8ad11e495a6d6fa94b7a0cbede567c4e8d503990b305016423975
```

display the tree of an image layer
```bash=
podman image tree localhost/nginx:latest
```

see some goodies
```bash=
ls /var/db/containers/storage/zfs-containers/${JAIL_ID}/userdata
cat /var/db/containers/storage/zfs-containers/${JAIL_ID}/userdata/config.json
```

Kill a runaway process (or send any signal to the container's running process)
```bash=
podman kill -s 9 base-nginx
```

See stopped containers
```bash=
podman ps -a
```
```
CONTAINER ID  IMAGE                   COMMAND     CREATED        STATUS                      PORTS                 NAMES
c7674a02b085  localhost/nginx:latest              7 minutes ago  Exited (137) 8 seconds ago  0.0.0.0:8080->80/tcp  base-nginx
```

attach to the base-nginx container
```bash=
podman start base-nginx
# unstable
podman attach base-nginx
```
exit with ctrl+Z
