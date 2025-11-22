---
icon: fontawesome/brands/golang
---

# :fontawesome-brands-golang:{ .golang } Go

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fgolang),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com/docker-library/golang](https://github.com/docker-library/golang)
* FreeBSD fork: [https://github.com/matias-pizarro/docker-golang](https://github.com/matias-pizarro/docker-golang)



=== "Usage"

    --8<-- "docs/images/golang/content.md"


=== "Containerfile"

     images/14.3/golang/1.25/Containerfile [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/golang/1.25/Containerfile"
    ```

=== "Build"

     images/14.3/golang/1.25/ci_cd/build.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/ci_cd/build.sh)

    ```console
    --8<-- "images/14.3/golang/1.25/ci_cd/build.sh:6"
    ```

=== "Test"

     images/14.3/golang/1.25/ci_cd/test.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/ci_cd/test.sh)

    ```console
    --8<-- "images/14.3/golang/1.25/ci_cd/test.sh:6"
    ```

=== "Push"

     images/14.3/golang/1.25/ci_cd/push.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/ci_cd/push.sh)

    ```console
    --8<-- "images/14.3/golang/1.25/ci_cd/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [1.20-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.21-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.22-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.23-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.24-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.20-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.21-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.22-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.23-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.24-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.20-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.21-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.22-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.23-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.24-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.20-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.21-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.22-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.23-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.24-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.20-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.20.14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.21-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.21.13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.22-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.22.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.23-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.23.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1.24-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.24.9-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    
    * [1-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [1.25.4-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)
    

=== "License"

     images/14.3/golang/1.25/LICENSE [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/LICENSE)

    ```console
    --8<-- "images/14.3/golang/1.25/LICENSE"
    ```