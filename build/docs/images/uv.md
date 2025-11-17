# uv

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fuv),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com/astral-sh/uv](https://github.com/astral-sh/uv)
* FreeBSD fork: [https://github.com/matias-pizarro/uv](https://github.com/matias-pizarro/uv)


=== "Containerfile"

     [images/14.3/uv/3.11/Containerfile](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/uv/3.11/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/uv/3.11/Containerfile"
    ```

=== "Build"

     [images/14.3/uv/3.11/build.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/uv/3.11/build.sh)

    ```console
    --8<-- "images/14.3/uv/3.11/build.sh:6"
    ```

=== "Test"

     [images/14.3/uv/3.11/test.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/uv/3.11/test.sh)

    ```console
    --8<-- "images/14.3/uv/3.11/test.sh:6:-2"
    ```

=== "Push"

     [images/14.3/uv/3.11/push.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/uv/3.11/push.sh)

    ```console
    --8<-- "images/14.3/uv/3.11/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [3.10-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.10/Containerfile), [3.10-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.10/Containerfile), [3.10-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.10/Containerfile)
    
    * [3-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [3-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [3-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [3.11-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [3.11-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [3.11-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.11/Containerfile)
    
    * [3.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.12/Containerfile), [3.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.12/Containerfile), [3.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.12/Containerfile)
    
    * [3.13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.13/Containerfile), [3.13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.13/Containerfile), [3.13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.13/Containerfile)
    
    * [3.14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.14/Containerfile), [3.14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.14/Containerfile), [3.14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/uv/3.14/Containerfile)
    
    * [3.10-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.10/Containerfile)
    
    * [3-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.11/Containerfile), [3.11-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.11/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.11/Containerfile)
    
    * [3.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.12/Containerfile)
    
    * [3.13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.13/Containerfile)
    
    * [3.14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/uv/3.14/Containerfile)
    
    * [3.10-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.10/Containerfile), [3.10-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.10/Containerfile)
    
    * [3-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.11/Containerfile), [3-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.11/Containerfile), [3.11-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.11/Containerfile), [3.11-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.11/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.11/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.11/Containerfile)
    
    * [3.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.12/Containerfile), [3.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.12/Containerfile)
    
    * [3.13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.13/Containerfile), [3.13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.13/Containerfile)
    
    * [3.14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.14/Containerfile), [3.14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/uv/3.14/Containerfile)
    
    * [3.10-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.10/Containerfile)
    
    * [3-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.11/Containerfile), [3.11-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.11/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.11/Containerfile)
    
    * [3.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.12/Containerfile)
    
    * [3.13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.13/Containerfile)
    
    * [3.14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/uv/3.14/Containerfile)
    
    * [3.10-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.10/Containerfile), [3.10-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.10/Containerfile)
    
    * [3-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.11/Containerfile), [3-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.11/Containerfile), [3.11-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.11/Containerfile), [3.11-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.11/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.11/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.11/Containerfile)
    
    * [3.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.12/Containerfile), [3.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.12/Containerfile)
    
    * [3.13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.13/Containerfile), [3.13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.13/Containerfile)
    
    * [3.14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.14/Containerfile), [3.14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/uv/3.14/Containerfile)
    

=== "License"

     [images/14.3/uv/3.11/LICENSE](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/uv/3.11/LICENSE)

    ```console
    --8<-- "images/14.3/uv/3.11/LICENSE"
    ```