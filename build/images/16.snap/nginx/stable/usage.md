
# How to use this image

## Hosting some simple static content

```console
$ podman run --replace --detach --name some-nginx \
-v ./examples/static-html-directory:/usr/local/www/nginx:ro freebsd-nginx-stable
```

Alternatively, a simple `Dockerfile` can be used to generate a new image that includes the necessary content (which is a much cleaner solution than the bind mount above):

```dockerfile
FROM freebsd-nginx-stable
COPY static-html-directory /usr/local/www/nginx
```


Place this file in the same directory as your directory of content ("static-html-directory"), then run these commands to build and start your container:

```console
$ podman build -t some-content-nginx examples
$ podman run --replace --detach --name some-nginx some-content-nginx
```


## Exposing external port

```console
$ podman run --replace --detach --publish \
    --name some-nginx 8080:80 some-content-nginx
```

Then you can hit `http://localhost:8080` or `http://host-ip:8080` in your browser.

## Customize configuration

You can mount your configuration file, or build a new image with it.

If you wish to adapt the default configuration, use something like the following to get it from a running nginx container:

```console
$ podman run --rm --entrypoint=cat freebsd-nginx-stable \
    /usr/local/etc/nginx/nginx.conf > ./examples/custom-nginx-conf/nginx.conf
```

And then edit examples/custom-nginx-conf/nginx-conf in your host file system.

For information on the syntax of the nginx configuration files, see [the official documentation](http://nginx.org/en/docs/) (specifically the [Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html#conf_structure)).

### Mount your configuration file

```console
$ podman run --replace --detach --name my-custom-nginx-container \
    -v ./examples/custom-nginx-conf/nginx.conf:/etc/nginx/nginx.conf:ro \
    freebsd-nginx-stable
```

### Build a new image with your configuration file

```dockerfile
FROM freebsd-nginx-stable
COPY nginx.conf /usr/local/etc/nginx/nginx.conf
```

If you add a custom `CMD` in the Dockerfile, be sure to include `-g daemon off;` in the `CMD` in order for nginx to stay in the foreground, so that podman can track the process properly (otherwise your container will stop immediately after starting)!

Then build the image with `docker build -t custom-nginx examples/custom-nginx-conf` and run it as follows:

```console
$ podman run --name my-custom-nginx-container --detach custom-nginx
```

### Using environment variables in nginx configuration (new in 1.19)

Out-of-the-box, nginx doesn't support environment variables inside most configuration blocks. But this image has a function, which will extract environment variables before nginx starts.

Here is an example using `compose.yaml`:

```yaml
web:
  image: nginx
  volumes:
   - ./templates:/etc/nginx/templates
  ports:
   - "8080:80"
  environment:
   - NGINX_HOST=foobar.com
   - NGINX_PORT=80
```

By default, this function reads template files in `/etc/nginx/templates/*.template` and outputs the result of executing `envsubst` to `/etc/nginx/conf.d`.

So if you place `templates/default.conf.template` file, which contains variable references like this:

	listen       ${NGINX_PORT};

outputs to `/etc/nginx/conf.d/default.conf` like this:

	listen       80;

This behavior can be changed via the following environment variables:

-	`NGINX_ENVSUBST_TEMPLATE_DIR`
	-	A directory which contains template files (default: `/etc/nginx/templates`)
	-	When this directory doesn't exist, this function will do nothing about template processing.
-	`NGINX_ENVSUBST_TEMPLATE_SUFFIX`
	-	A suffix of template files (default: `.template`)
	-	This function only processes the files whose name ends with this suffix.
-	`NGINX_ENVSUBST_OUTPUT_DIR`
	-	A directory where the result of executing envsubst is output (default: `/etc/nginx/conf.d`)
	-	The output filename is the template filename with the suffix removed.
		-	ex.) `/etc/nginx/templates/default.conf.template` will be output with the filename `/etc/nginx/conf.d/default.conf`.
	-	This directory must be writable by the user running a container.

## Running nginx in read-only mode

To run nginx in read-only mode, you will need to mount a podman volume to every location where nginx writes information. The default nginx configuration requires write access to `/var/cache/nginx` and `/var/run`. This can be easily accomplished by running nginx as follows:

```console
$ podman run --replace --detach --publish 80:80 --read-only -v $(pwd)/nginx-cache:/var/cache/nginx -v $(pwd)/nginx-pid:/var/run nginx
```

If you have a more advanced configuration that requires nginx to write to other locations, simply add more volume mounts to those locations.

## Running nginx in debug mode

Images since version 1.9.8 come with `nginx-debug` binary that produces verbose output when using higher log levels. It can be used with simple CMD substitution:

```console
$ podman run --name my-nginx -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro --detach nginx nginx-debug -g 'daemon off;'
```

Similar configuration in `compose.yaml` may look like this:

```yaml
web:
  image: nginx
  volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf:ro
  command: [nginx-debug, '-g', 'daemon off;']
```

## Entrypoint quiet logs

Since version 1.19.0, a verbose entrypoint was added. It provides information on what's happening during container startup. You can silence this output by setting environment variable `NGINX_ENTRYPOINT_QUIET_LOGS`:

```console
$ podman run --detach -e NGINX_ENTRYPOINT_QUIET_LOGS=1 nginx
```

## User and group id

Since 1.17.0, both alpine- and debian-based images variants use the same user and group ids to drop the privileges for worker processes:

```console
$ id
uid=101(nginx) gid=101(nginx) groups=101(nginx)
```

## Running nginx as a non-root user

It is possible to run the image as a less privileged arbitrary UID/GID. This, however, requires modification of nginx configuration to use directories writeable by that specific UID/GID pair:

```console
$ podman run --detach -v $PWD/nginx.conf:/etc/nginx/nginx.conf nginx
```

where nginx.conf in the current directory should have the following directives re-defined:

```nginx
pid        /tmp/nginx.pid;
```

And in the http context:

```nginx
http {
    client_body_temp_path /tmp/client_temp;
    proxy_temp_path       /tmp/proxy_temp_path;
    fastcgi_temp_path     /tmp/fastcgi_temp;
    uwsgi_temp_path       /tmp/uwsgi_temp;
    scgi_temp_path        /tmp/scgi_temp;
...
}
```

