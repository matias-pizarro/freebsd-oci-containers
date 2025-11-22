## What is Node.js?

Node.js is a software platform for scalable server-side and networking applications. Node.js applications are written in JavaScript and can be run within the Node.js runtime on Mac OS X, Windows, and Linux without changes.

Node.js applications are designed to maximize throughput and efficiency, using non-blocking I/O and asynchronous events. Node.js applications run single-threaded, although Node.js uses multiple threads for file and network events. Node.js is commonly used for real-time applications due to its asynchronous nature.

Node.js internally uses the Google V8 JavaScript engine to execute code; a large percentage of the basic modules are written in JavaScript. Node.js contains a built-in, asynchronous I/O library for file, socket, and HTTP communication. The HTTP and socket support allows Node.js to act as a web server without additional software such as Apache.

> [wikipedia.org/wiki/Node.js](https://en.wikipedia.org/wiki/Node.js)

![Project logo](logo.png)

## How to use this image

### Create a `Containerfile` in your Node.js app project

```Containerfile
--8<-- "docs/images/node/examples/Containerfile"
```

You can then build and run the OCI image:

```console
podman build -t my-nodejs-app .
podman run -it --rm --name my-running-app my-nodejs-app
```

If you prefer Podman Compose:

```yml
--8<-- "docs/images/node/examples/compose.yaml"
```

You can then run using Podman Compose:

```console
podman-compose up -d
```

Podman Compose example mounts your current directory (including node_modules) to the container.
It assumes that your application has a file named [`package.json`](https://docs.npmjs.com/files/package.json)
defining [start script](https://docs.npmjs.com/misc/scripts#default-values).

### Best Practices

We have assembled a [Best Practices Guide](./docs/BestPractices.md) for those using these images on a daily basis.

### Run a single Node.js script

For many simple, single file projects, you may find it inconvenient to write a
complete `Containerfile`. In such cases, you can run a Node.js script by using the
Node.js OCI image directly:

```console
podman run -it --rm --name my-running-script -v "$PWD":/usr/src/app -w /usr/src/app node:22 node your-daemon-or-script.js
```

### Verbosity

Prior to 8.7.0 and 6.11.4, the docker images overrode the default npm log
level from `warn` to `info`. However, due to improvements to npm and new Docker
patterns (e.g. multi-stage builds) the working group reached a [consensus](https://github.com/nodejs/docker-node/issues/528)
to revert the log level to npm defaults. If you need more verbose output, please
use one of the following methods to change the verbosity level.

#### Containerfile

If you create your own `Containerfile` which inherits from the `node` image, you can
simply use `ENV` to override `NPM_CONFIG_LOGLEVEL`.

```Containerfile
FROM node
ENV NPM_CONFIG_LOGLEVEL=info
...
```

#### Podman Run

If you run the node image using `podman run`, you can use the `-e` flag to
override `NPM_CONFIG_LOGLEVEL`.

```console
podman run -e NPM_CONFIG_LOGLEVEL=info node ...
```

#### NPM run

If you are running npm commands, you can use `--loglevel` to control the
verbosity of the output.

```console
podman run node npm --loglevel=warn ...
```
