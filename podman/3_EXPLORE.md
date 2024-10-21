# Explore

* Pre-requisite: a working podman set-up (see [Setup podman](#1-setup.md))

launch the nginx-base service
  * stateless, tailing the error log in the foreground
  * when stopped, state is destroyed
```bash=
podman run --rm --name nginx-base -p 8080:80 localhost/nginx
```

send the service to the background
```bash=
ctrl+Z
```

stop it
```bash=
podman stop nginx-base
```

launch the nginx-base service
  * stateless, in the background
```bash=
JAIL_ID=$(podman run -d --rm --name nginx-base -p 8080:80 localhost/nginx)
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


launch the nginx-base service
  * state is preserved across start/stop cycles
  * the new container replaces the running one
```bash=
podman run --replace -d --name nginx-base -p 8080:80 localhost/nginx
podman exec -it nginx-base /bin/sh
```
In the container
```bash=
echo 2 > /root/test.txt
```
On the host
```bash=
podman exec -it nginx-base cat /root/test.txt
```
```
2
```
```bash=
podman stop nginx-base
podman start nginx-base
podman exec -it nginx-base cat /root/test.txt
```
```
2
```

tail the error log
```bash=
podman logs -f nginx-base
```
or
```bash=
podman exec -it nginx-base tail -F /var/log/nginx/error.log
```

tail the access log
```bash=
podman exec -it nginx-base tail -F /var/log/nginx/access.log
```

see the list of running containers
```bash=
podman ps
```
```
CONTAINER ID  IMAGE                   COMMAND     CREATED         STATUS         PORTS                 NAMES
3197cf742d93  localhost/nginx:latest              26 minutes ago  Up 24 minutes  0.0.0.0:8080->80/tcp  nginx-base
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
IP=$(podman exec -it nginx-base ifconfig eth0 inet | grep inet | awk '{print $2}')
echo ${IP}
```

```
10.88.0.25
```

inspect the container
```bash=
podman inspect nginx-base
```
see the output [at the bottom of the page](#output-of-podman-inspect-nginx-base), it's a bit long

```bash=
JAIL_ID=$(podman inspect nginx-base | grep Id | awk -F '"' '{print $4}')
JAIL_IP=$(podman inspect nginx-base | grep -m 1 IPAddress | awk -F '"' '{print $4}')
echo "jail id: ${JAIL_ID}" && echo "jail ip: ${JAIL_IP}"
```

```
jail id: c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e
jail ip: 10.88.0.27
```

Check that the nginx server is actually responding
```bash=
curl -v ${JAIL_IP}
```

```html
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
podman exec -it nginx-base service nginx reload
```
or
```bash=
jexec ${JAIL_ID} service nginx reload
```

get the jail's base filesystem mountpoint

```bash=
JAIL_ROOT=$(podman mount nginx-base)
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
c7674a02b085  nginx-base  0.00%       0B / 66.22GB       0.00%       1.278kB / 3.459kB  0B / 0B     0           0s          0.00%
```

```bash=
podman generate kube nginx-base 
```

```yaml
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
    app: nginx-base-pod
  name: nginx-base-pod
spec:
  containers:
  - image: localhost/nginx:latest
    name: nginx-base
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
podman kill -s 9 nginx-base
```

See stopped containers
```bash=
podman ps -a
```
```
CONTAINER ID  IMAGE                   COMMAND     CREATED        STATUS                      PORTS                 NAMES
c7674a02b085  localhost/nginx:latest              7 minutes ago  Exited (137) 8 seconds ago  0.0.0.0:8080->80/tcp  nginx-base
```

attach to the nginx-base container
```bash=
podman start nginx-base
# unstable
podman attach nginx-base
```
exit with ctrl+Z

========================================

### output of podman inspect nginx-base
```json
[
     {
          "Id": "c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e",
          "Created": "2024-10-16T15:19:16.935517862+02:00",
          "Path": "/usr/local/bin/run.sh",
          "Args": [
               "/usr/local/bin/run.sh"
          ],
          "State": {
               "OciVersion": "1.2.0",
               "Status": "running",
               "Running": true,
               "Paused": false,
               "Restarting": false,
               "OOMKilled": false,
               "Dead": false,
               "Pid": 68426,
               "ConmonPid": 67079,
               "ExitCode": 0,
               "Error": "",
               "StartedAt": "2024-10-16T15:32:22.24863305+02:00",
               "FinishedAt": "2024-10-16T15:26:21.290131+02:00",
               "CheckpointedAt": "0001-01-01T00:00:00Z",
               "RestoredAt": "0001-01-01T00:00:00Z"
          },
          "Image": "02b3df058b3b38a2e6f8bfa3a84b99e49eb2483b60dac408247698350a0c3104",
          "ImageDigest": "sha256:1f4f963ed2a77ace394b154ca15431b6de714bfee42c04d740083a50d8755a36",
          "ImageName": "localhost/nginx:latest",
          "Rootfs": "",
          "Pod": "",
          "ResolvConfPath": "/var/run/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata/resolv.conf",
          "HostnamePath": "",
          "HostsPath": "/var/run/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata/hosts",
          "StaticDir": "/var/db/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata",
          "OCIConfigPath": "/var/db/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata/config.json",
          "OCIRuntime": "ocijail",
          "ConmonPidFile": "/var/run/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata/conmon.pid",
          "PidFile": "/var/run/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata/pidfile",
          "Name": "nginx-base",
          "RestartCount": 0,
          "Driver": "zfs",
          "MountLabel": "",
          "ProcessLabel": "",
          "AppArmorProfile": "",
          "EffectiveCaps": null,
          "BoundingCaps": null,
          "ExecIDs": [],
          "GraphDriver": {
               "Name": "zfs",
               "Data": {
                    "Dataset": "zroot/TOOLING/oci/containers/255c8654d32243862e2590212b930f74ea0ae6c9f0ed24dc124628e03375eb81",
                    "Mountpoint": "/var/db/containers/storage/zfs/graph/255c8654d32243862e2590212b930f74ea0ae6c9f0ed24dc124628e03375eb81"
               }
          },
          "Mounts": [
               {
                    "Type": "volume",
                    "Name": "90ab56b460bf6dc88769f034304df75153b4d458da0a2cf6590cb7d7a13871b6",
                    "Source": "/var/db/containers/storage/volumes/90ab56b460bf6dc88769f034304df75153b4d458da0a2cf6590cb7d7a13871b6/_data",
                    "Destination": "/var/cache/pkg",
                    "Driver": "local",
                    "Mode": "",
                    "Options": [
                         "nodev",
                         "exec",
                         "rbind"
                    ],
                    "RW": true,
                    "Propagation": "rprivate"
               }
          ],
          "Dependencies": [],
          "NetworkSettings": {
               "EndpointID": "",
               "Gateway": "10.88.0.1",
               "IPAddress": "10.88.0.27",
               "IPPrefixLen": 16,
               "IPv6Gateway": "",
               "GlobalIPv6Address": "",
               "GlobalIPv6PrefixLen": 0,
               "MacAddress": "02:28:39:45:d4:0b",
               "Bridge": "",
               "SandboxID": "",
               "HairpinMode": false,
               "LinkLocalIPv6Address": "",
               "LinkLocalIPv6PrefixLen": 0,
               "Ports": {
                    "80/tcp": [
                         {
                              "HostIp": "0.0.0.0",
                              "HostPort": "8080"
                         }
                    ]
               },
               "SandboxKey": "c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e",
               "Networks": {
                    "podman": {
                         "EndpointID": "",
                         "Gateway": "10.88.0.1",
                         "IPAddress": "10.88.0.27",
                         "IPPrefixLen": 16,
                         "IPv6Gateway": "",
                         "GlobalIPv6Address": "",
                         "GlobalIPv6PrefixLen": 0,
                         "MacAddress": "02:28:39:45:d4:0b",
                         "NetworkID": "podman",
                         "DriverOpts": null,
                         "IPAMConfig": null,
                         "Links": null,
                         "Aliases": [
                              "c7674a02b085"
                         ]
                    }
               }
          },
          "Namespace": "",
          "IsInfra": false,
          "IsService": false,
          "KubeExitCodePropagation": "invalid",
          "lockNumber": 6,
          "Config": {
               "Hostname": "c7674a02b085",
               "Domainname": "",
               "User": "",
               "AttachStdin": false,
               "AttachStdout": false,
               "AttachStderr": false,
               "Tty": false,
               "OpenStdin": false,
               "StdinOnce": false,
               "Env": [
                    "container=podman",
                    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                    "HOME=/root",
                    "HOSTNAME=c7674a02b085"
               ],
               "Cmd": null,
               "Image": "localhost/nginx:latest",
               "Volumes": null,
               "WorkingDir": "/",
               "Entrypoint": [
                    "/usr/local/bin/run.sh"
               ],
               "OnBuild": null,
               "Labels": {
                    "io.buildah.version": "1.36.0"
               },
               "Annotations": {
                    "io.container.manager": "libpod",
                    "org.freebsd.jail.vnet": "new",
                    "org.opencontainers.image.stopSignal": "15"
               },
               "StopSignal": "SIGTERM",
               "HealthcheckOnFailureAction": "none",
               "CreateCommand": [
                    "podman",
                    "run",
                    "--replace",
                    "-d",
                    "--name",
                    "nginx-base",
                    "-p",
                    "8080:80",
                    "localhost/nginx"
               ],
               "Umask": "0022",
               "Timeout": 0,
               "StopTimeout": 10,
               "Passwd": true,
               "sdNotifyMode": "container"
          },
          "HostConfig": {
               "Binds": [
                    "90ab56b460bf6dc88769f034304df75153b4d458da0a2cf6590cb7d7a13871b6:/var/cache/pkg:rprivate,rw,nodev,exec,rbind"
               ],
               "CgroupMode": "",
               "ContainerIDFile": "",
               "LogConfig": {
                    "Type": "k8s-file",
                    "Config": null,
                    "Path": "/var/db/containers/storage/zfs-containers/c7674a02b0850e0e6539fe39faea28f0dc2f5ade0afd355f74932fd97082771e/userdata/ctr.log",
                    "Tag": "",
                    "Size": "0B"
               },
               "NetworkMode": "bridge",
               "PortBindings": {
                    "80/tcp": [
                         {
                              "HostIp": "0.0.0.0",
                              "HostPort": "8080"
                         }
                    ]
               },
               "RestartPolicy": {
                    "Name": "no",
                    "MaximumRetryCount": 0
               },
               "AutoRemove": false,
               "Annotations": {
                    "io.container.manager": "libpod",
                    "org.freebsd.jail.vnet": "new",
                    "org.opencontainers.image.stopSignal": "15"
               },
               "VolumeDriver": "",
               "VolumesFrom": null,
               "CapAdd": null,
               "CapDrop": null,
               "Dns": [],
               "DnsOptions": [],
               "DnsSearch": [],
               "ExtraHosts": [],
               "GroupAdd": [],
               "IpcMode": "",
               "Cgroup": "",
               "Cgroups": "default",
               "Links": null,
               "OomScoreAdj": 0,
               "PidMode": "host",
               "Privileged": false,
               "PublishAllPorts": false,
               "ReadonlyRootfs": false,
               "SecurityOpt": [],
               "Tmpfs": {},
               "UTSMode": "host",
               "UsernsMode": "",
               "ShmSize": 0,
               "Runtime": "oci",
               "ConsoleSize": [
                    0,
                    0
               ],
               "Isolation": "",
               "CpuShares": 0,
               "Memory": 0,
               "NanoCpus": 0,
               "CgroupParent": "",
               "BlkioWeight": 0,
               "BlkioWeightDevice": null,
               "BlkioDeviceReadBps": null,
               "BlkioDeviceWriteBps": null,
               "BlkioDeviceReadIOps": null,
               "BlkioDeviceWriteIOps": null,
               "CpuPeriod": 0,
               "CpuQuota": 0,
               "CpuRealtimePeriod": 0,
               "CpuRealtimeRuntime": 0,
               "CpusetCpus": "",
               "CpusetMems": "",
               "Devices": [],
               "DiskQuota": 0,
               "KernelMemory": 0,
               "MemoryReservation": 0,
               "MemorySwap": 0,
               "MemorySwappiness": 0,
               "OomKillDisable": false,
               "PidsLimit": 0,
               "Ulimits": [],
               "CpuCount": 0,
               "CpuPercent": 0,
               "IOMaximumIOps": 0,
               "IOMaximumBandwidth": 0,
               "CgroupConf": null
          }
     }
]
```