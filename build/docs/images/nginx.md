# Nginx

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fnginx),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com/nginx/docker-nginx](https://github.com/nginx/docker-nginx)
* FreeBSD fork: [https://github.com/matias-pizarro/docker-nginx](https://github.com/matias-pizarro/docker-nginx)


=== "Usage"

    --8<-- "images/14.3/nginx/stable/usage.md"


=== "Containerfile"

     [images/14.3/nginx/stable/Containerfile](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/nginx/stable/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/nginx/stable/Containerfile"
    ```

=== "Build"

     [images/14.3/nginx/stable/build.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/nginx/stable/build.sh)

    ```console
    --8<-- "images/14.3/nginx/stable/build.sh:6"
    ```

=== "Test"

     [images/14.3/nginx/stable/test.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/nginx/stable/test.sh)

    ```console
    --8<-- "images/14.3/nginx/stable/test.sh:6:-2"
    ```

=== "Push"

     [images/14.3/nginx/stable/push.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/nginx/stable/push.sh)

    ```console
    --8<-- "images/14.3/nginx/stable/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/stable/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/stable/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/stable/Containerfile), [stable-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/stable/Containerfile), [stable-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/stable/Containerfile), [stable-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/stable/Containerfile)
    
    * [mainline-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/mainline/Containerfile), [mainline-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/mainline/Containerfile), [mainline-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/nginx/mainline/Containerfile)
    
    * [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/nginx/stable/Containerfile), [stable-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/nginx/stable/Containerfile)
    
    * [mainline-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/nginx/mainline/Containerfile)
    
    * [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/nginx/stable/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/nginx/stable/Containerfile), [stable-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/nginx/stable/Containerfile), [stable-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/nginx/stable/Containerfile)
    
    * [mainline-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/nginx/mainline/Containerfile), [mainline-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/nginx/mainline/Containerfile)
    
    * [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/nginx/stable/Containerfile), [stable-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/nginx/stable/Containerfile)
    
    * [mainline-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/nginx/mainline/Containerfile)
    
    * [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/nginx/stable/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/nginx/stable/Containerfile), [stable-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/nginx/stable/Containerfile), [stable-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/nginx/stable/Containerfile)
    
    * [mainline-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/nginx/mainline/Containerfile), [mainline-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/nginx/mainline/Containerfile)
    

=== "License"

     [images/14.3/nginx/stable/LICENSE](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/nginx/stable/LICENSE)

    ```console
    --8<-- "images/14.3/nginx/stable/LICENSE"
    ```