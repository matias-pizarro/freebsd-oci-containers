---
icon: simple/python
---

# :simple-python:{ .python } Python

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fpython),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com/docker-library/python](https://github.com/docker-library/python)
* FreeBSD fork: [https://github.com/matias-pizarro/docker-python](https://github.com/matias-pizarro/docker-python)



=== "Usage"

    --8<-- "docs/images/python/content.md"


=== "Containerfile"

     images/14.3/python/3.11/Containerfile [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/python/3.11/Containerfile"
    ```

=== "Build"

     images/14.3/python/3.11/ci_cd/build.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/ci_cd/build.sh)

    ```console
    --8<-- "images/14.3/python/3.11/ci_cd/build.sh:6"
    ```

=== "Test"

     images/14.3/python/3.11/ci_cd/test.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/ci_cd/test.sh)

    ```console
    --8<-- "images/14.3/python/3.11/ci_cd/test.sh:6"
    ```

=== "Push"

     images/14.3/python/3.11/ci_cd/push.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/ci_cd/push.sh)

    ```console
    --8<-- "images/14.3/python/3.11/ci_cd/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [3.10-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.10-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.10-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.10-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.10-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.10-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.10-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.10-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.10-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile), [3.14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/Containerfile)
    

=== "License"

     images/14.3/python/3.11/LICENSE [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/python/3.11/LICENSE)

    ```console
    --8<-- "images/14.3/python/3.11/LICENSE"
    ```