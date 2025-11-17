# Node.js

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fnode),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com/nodejs/docker-node](https://github.com/nodejs/docker-node)
* FreeBSD fork: [https://github.com/matias-pizarro/docker-node](https://github.com/matias-pizarro/docker-node)


=== "Containerfile"

     [images/14.3/node/24/Containerfile](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/node/24/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/node/24/Containerfile"
    ```

=== "Build"

     [images/14.3/node/24/build.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/node/24/build.sh)

    ```console
    --8<-- "images/14.3/node/24/build.sh:6"
    ```

=== "Test"

     [images/14.3/node/24/test.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/node/24/test.sh)

    ```console
    --8<-- "images/14.3/node/24/test.sh:6:-2"
    ```

=== "Push"

     [images/14.3/node/24/push.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/node/24/push.sh)

    ```console
    --8<-- "images/14.3/node/24/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [20-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/20/Containerfile), [20-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/20/Containerfile), [20-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/20/Containerfile)
    
    * [22-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/22/Containerfile), [22-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/22/Containerfile), [22-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/22/Containerfile)
    
    * [24-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/24/Containerfile), [24-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/24/Containerfile), [24-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/24/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/24/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/24/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/24/Containerfile)
    
    * [25-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/25/Containerfile), [25-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/25/Containerfile), [25-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/node/25/Containerfile)
    
    * [20-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/node/20/Containerfile)
    
    * [22-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/node/22/Containerfile)
    
    * [24-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/node/24/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/node/24/Containerfile)
    
    * [25-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/node/25/Containerfile)
    
    * [20-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/20/Containerfile), [20-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/20/Containerfile)
    
    * [22-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/22/Containerfile), [22-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/22/Containerfile)
    
    * [24-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/24/Containerfile), [24-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/24/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/24/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/24/Containerfile)
    
    * [25-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/25/Containerfile), [25-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/node/25/Containerfile)
    
    * [20-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/node/20/Containerfile)
    
    * [22-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/node/22/Containerfile)
    
    * [24-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/node/24/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/node/24/Containerfile)
    
    * [25-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/node/25/Containerfile)
    
    * [20-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/20/Containerfile), [20-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/20/Containerfile)
    
    * [22-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/22/Containerfile), [22-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/22/Containerfile)
    
    * [24-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/24/Containerfile), [24-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/24/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/24/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/24/Containerfile)
    
    * [25-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/25/Containerfile), [25-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/node/25/Containerfile)
    

=== "License"

     [images/14.3/node/24/LICENSE](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/node/24/LICENSE)

    ```console
    --8<-- "images/14.3/node/24/LICENSE"
    ```