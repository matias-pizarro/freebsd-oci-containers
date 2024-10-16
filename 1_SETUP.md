# Setting the Podman/Buildah/Runj ecosystem up

* **[Guides](##Guides)**: in-depth, detailed installation process information
* **[Quickstart](##Quickstart)**: verything you need for aa barebones happy path
  * [Packages](#packages)
  * [Storage](#storage)
  * [Networking](#networking)
  * [Finishing touches](#finishing-touches)
  * [Building your own base images](#building-your-own-base-images)

## Guides
> * **the most comprehensive: https://docs.skunkwerks.at/LqHthEkTSeGDwV0PDUQSyg**
* https://docs.podman.io/en/stable/markdown/podman.1.html
* https://podman.io/docs/installation#installing-on-freebsd-140
* https://github.com/oci-playground/freebsd-podman-testing?tab=readme-ov-file

## Quickstart / Barebones initial set-up

### Packages

Install the podman suite of tools
```
pkg install podman-suite
```

Make sure you leverage the **invaluable** shell completions
https://docs.podman.io/en/v3.0/markdown/podman-completion.1.html
``` bash
# bash
pkg install bash_completion
podman completion bash
# zsh
pkg install zsh-completions
podman completion zsh
# fish
# https://fishshell.com/docs/current/completions.html
podman completion fish
```

### Storage
* if you use ZFS
    ```
    zfs create -o mountpoint=/var/db/containers zroot/containers
    zfs snapshot zroot/containers@empty
    ```
* if you do not use ZFS, change storage.conf to use the vfs storage driver:
    ```
    sed -I .bak -e 's|driver = "zfs"|driver = "vfs"|' /usr/local/etc/containers/storage.conf
    ```

### Networking
Container networking relies on NAT to allow container network packets out to the host's network. This requires a PF firewall to perform the translation. A simple example is included - to use it:


* if you already use pf:
    * integrate the directives found in `/usr/local/etc/containers/pf.conf.sample` into your pf.conf
    * enable redirections:
      ```
      sysctl net.pf.filter_local=1
      echo 'net.pf.filter_local=1' >> /etc/sysctl.conf.local
      ```
    * reload definitions/nat/redirections/rules with:
      ```
      pfctl -F all -f /etc/pf.conf
      ```
* if you don't use pf yet:
    * ```
      cp /usr/local/etc/containers/pf.conf.sample /etc/pf.conf
      ```
    * Edit /etc/pf.conf and set v4egress_if, v6egress_if variables to your network interface(s)s

    * Enable and start pf:
      ```
      kldload pf
      sysctl net.pf.filter_local=1
      echo 'net.pf.filter_local=1' >> /etc/sysctl.conf.local
      service pf enable
      service pf start
      ```

### Finishing touches

To properly support Podman's container restart policy, conmon needs fdescfs(5) to be mounted on /dev/fd.

If /dev/fd is not already mounted:
```
mount -t fdescfs fdesc /dev/fd
```

To make it permanent, add the following line to /etc/fstab:
```
fdesc   /dev/fd         fdescfs         rw      0       0
```

Optional: to auto-start the Podman service after boot
```
service podman enable
```

### Building your own base images
* https://github.com/oci-playground/freebsd-podman-testing?tab=readme-ov-file#building-your-own-container
* https://gitlab.com/bergblume/freebsd-images
* https://github.com/dfr/freebsd-images

```
pkg install emulators/qemu-user-static jq
```
