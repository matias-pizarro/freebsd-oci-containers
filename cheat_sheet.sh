#!/dev/null

podman run --rm -it --name pulumi-dev \
    -v /home/mpizarro/devel/matias-pizarro/pulumi:/home/mpizarro/devel/matias-pizarro/pulumi \
        localhost/pulumi-dev \
        /usr/local/bin/bash

podman run -it localhost/nginx /bin/sh

podman run --rm --name base-nginx localhost/nginx
podman exec -it base-nginx ifconfig

podman image prune

podman stop base-nginx && \
podman run -d --rm --name base-nginx -p 8080:80 localhost/nginx && \
podman logs -f base-nginx

podman exec -it base-nginx /bin/sh
podman exec -it base-nginx tail -F /var/log/nginx/error.log
podman exec -it base-nginx tail -F /var/log/nginx/access.log
podman exec -it base-nginx service nginx reload
jexec -j base-nginx service nginx reload

podman image tree localhost/nginx:latest







# launch the base-nginx service
# stateless, tailing the error log in the foreground
# when stopped state is destroyed
podman run --rm --name base-nginx -p 8080:80 localhost/nginx

# send the service to the background
ctrl+z

# recall it
fg

# launch the base-nginx service
# stateless, in the background
JAIL_ID=$(podman run -d --rm --name base-nginx -p 8080:80 localhost/nginx)

# tail the error log
podman logs -f base-nginx
# or
podman exec -it base-nginx tail -F /var/log/nginx/error.log

# tail the access log
podman exec -it base-nginx tail -F /var/log/nginx/access.log

# see the list of running containers
podman ps
# or
jls

# get the ip of a running container
IP=$(podman exec -ti base-nginx ifconfig eth0 inet | grep inet | awk '{print $2}')

# attach to the base-nginx container
podman attach base-nginx

# stop the base-nginx service
podman stop base-nginx

# see the now empty list of running containers
podman ps
# or
jls

# inspect the container
podman inspect base-nginx
JAIL_ID=$(podman inspect base-nginx | grep Id | awk -F '"' '{print $4}')
JAIL_IP=$(podman inspect base-nginx | grep -m 1 IPAddress | awk -F '"' '{print $4}')

# trigger an nginx reload 
podman exec -it base-nginx service nginx reload
# or
jexec ${JAIL_ID} service nginx reload

# get the jail's base fs mountpoint
JAIL_ROOT=$(podman mount base-nginx)
ls ${JAIL_ROOT}

# see a stream of container stats
podman stats

mpizarro@fm01:~ $ podman generate kube base-nginx 
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

# display the tree of an image layer
podman image tree localhost/nginx:latest


# see some goodies
ls /var/db/containers/storage/zfs-containers/${JAIL_ID}/userdata
cat /var/db/containers/storage/zfs-containers/${JAIL_ID}/userdata/config.json



# launch the base-nginx service
# stateless
podman run -d --name base-nginx -p 8080:80 localhost/nginx
