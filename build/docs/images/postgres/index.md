---
icon: simple/postgresql
---

# :simple-postgresql:{ .postgresql } Postgres

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fpostgres),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com//docker-library/postgres](https://github.com//docker-library/postgres)
* FreeBSD fork: [https://github.com/matias-pizarro/docker-postgres](https://github.com/matias-pizarro/docker-postgres)



=== "Usage"

    --8<-- "docs/images/postgres/content.md"


=== "Containerfile"

     images/14.3/postgres/18/Containerfile [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/postgres/18/Containerfile"
    ```

=== "Compose"

    ```yml
    --8<-- "docs/images/postgres/compose.yaml"
    ```


=== "Build"

     images/14.3/postgres/18/ci_cd/build.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/ci_cd/build.sh)

    ```console
    --8<-- "images/14.3/postgres/18/ci_cd/build.sh:6"
    ```

=== "Test"

     images/14.3/postgres/18/ci_cd/test.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/ci_cd/test.sh)

    ```console
    --8<-- "images/14.3/postgres/18/ci_cd/test.sh:6:-2"
    ```

=== "Push"

     images/14.3/postgres/18/ci_cd/push.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/ci_cd/push.sh)

    ```console
    --8<-- "images/14.3/postgres/18/ci_cd/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [15-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [15-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [15-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [16-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [16-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [16-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [17-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [17-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [17-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [18-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [15-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [16-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [17-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [18-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [15-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [15-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [16-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [16-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [17-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [17-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [18-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [15-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [16-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [17-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [18-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [15-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [15-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [16-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [16-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [17-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [17-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    
    * [18-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/Containerfile)
    

=== "License"

     images/14.3/postgres/18/LICENSE [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/postgres/18/LICENSE)

    ```console
    --8<-- "images/14.3/postgres/18/LICENSE"
    ```