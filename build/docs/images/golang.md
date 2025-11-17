# Go

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fgolang),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

* Upstream repo: [https://github.com/docker-library/golang](https://github.com/docker-library/golang)
* FreeBSD fork: [https://github.com/matias-pizarro/docker-golang](https://github.com/matias-pizarro/docker-golang)


=== "Containerfile"

     [images/14.3/golang/1.25/Containerfile](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/golang/1.25/Containerfile"
    ```

=== "Build"

     [images/14.3/golang/1.25/build.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/build.sh)

    ```console
    --8<-- "images/14.3/golang/1.25/build.sh:6"
    ```

=== "Test"

     [images/14.3/golang/1.25/test.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/test.sh)

    ```console
    --8<-- "images/14.3/golang/1.25/test.sh:6:-2"
    ```

=== "Push"

     [images/14.3/golang/1.25/push.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/push.sh)

    ```console
    --8<-- "images/14.3/golang/1.25/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [1.20-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.20.14.5/Containerfile), [1.20-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.20.14.5/Containerfile), [1.20-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.20.14.5/Containerfile), [1.20.14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.20.14.5/Containerfile), [1.20.14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.20.14.5/Containerfile), [1.20.14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.20.14.5/Containerfile)
    
    * [1.21-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.21.13.5/Containerfile), [1.21-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.21.13.5/Containerfile), [1.21-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.21.13.5/Containerfile), [1.21.13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.21.13.5/Containerfile), [1.21.13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.21.13.5/Containerfile), [1.21.13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.21.13.5/Containerfile)
    
    * [1.22-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.22.12.4/Containerfile), [1.22-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.22.12.4/Containerfile), [1.22-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.22.12.4/Containerfile), [1.22.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.22.12.4/Containerfile), [1.22.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.22.12.4/Containerfile), [1.22.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.22.12.4/Containerfile)
    
    * [1.23-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.23.12/Containerfile), [1.23-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.23.12/Containerfile), [1.23-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.23.12/Containerfile), [1.23.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.23.12/Containerfile), [1.23.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.23.12/Containerfile), [1.23.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.23.12/Containerfile)
    
    * [1.24-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.24.9/Containerfile), [1.24-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.24.9/Containerfile), [1.24-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.24.9/Containerfile), [1.24.9-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.24.9/Containerfile), [1.24.9-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.24.9/Containerfile), [1.24.9-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.24.9/Containerfile)
    
    * [1-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1.25-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1.25-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1.25-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1.25.4-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1.25.4-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [1.25.4-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/golang/1.25.4/Containerfile)
    
    * [1.20-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.20.14.5/Containerfile), [1.20.14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.20.14.5/Containerfile)
    
    * [1.21-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.21.13.5/Containerfile), [1.21.13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.21.13.5/Containerfile)
    
    * [1.22-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.22.12.4/Containerfile), [1.22.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.22.12.4/Containerfile)
    
    * [1.23-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.23.12/Containerfile), [1.23.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.23.12/Containerfile)
    
    * [1.24-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.24.9/Containerfile), [1.24.9-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.24.9/Containerfile)
    
    * [1-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.25.4/Containerfile), [1.25-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.25.4/Containerfile), [1.25.4-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.25.4/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/golang/1.25.4/Containerfile)
    
    * [1.20-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.20.14.5/Containerfile), [1.20-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.20.14.5/Containerfile), [1.20.14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.20.14.5/Containerfile), [1.20.14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.20.14.5/Containerfile)
    
    * [1.21-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.21.13.5/Containerfile), [1.21-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.21.13.5/Containerfile), [1.21.13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.21.13.5/Containerfile), [1.21.13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.21.13.5/Containerfile)
    
    * [1.22-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.22.12.4/Containerfile), [1.22-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.22.12.4/Containerfile), [1.22.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.22.12.4/Containerfile), [1.22.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.22.12.4/Containerfile)
    
    * [1.23-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.23.12/Containerfile), [1.23-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.23.12/Containerfile), [1.23.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.23.12/Containerfile), [1.23.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.23.12/Containerfile)
    
    * [1.24-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.24.9/Containerfile), [1.24-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.24.9/Containerfile), [1.24.9-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.24.9/Containerfile), [1.24.9-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.24.9/Containerfile)
    
    * [1-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [1-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [1.25-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [1.25-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [1.25.4-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [1.25.4-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/golang/1.25.4/Containerfile)
    
    * [1.20-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.20.14.5/Containerfile), [1.20.14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.20.14.5/Containerfile)
    
    * [1.21-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.21.13.5/Containerfile), [1.21.13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.21.13.5/Containerfile)
    
    * [1.22-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.22.12.4/Containerfile), [1.22.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.22.12.4/Containerfile)
    
    * [1.23-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.23.12/Containerfile), [1.23.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.23.12/Containerfile)
    
    * [1.24-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.24.9/Containerfile), [1.24.9-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.24.9/Containerfile)
    
    * [1-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.25.4/Containerfile), [1.25-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.25.4/Containerfile), [1.25.4-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.25.4/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/golang/1.25.4/Containerfile)
    
    * [1.20-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.20.14.5/Containerfile), [1.20-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.20.14.5/Containerfile), [1.20.14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.20.14.5/Containerfile), [1.20.14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.20.14.5/Containerfile)
    
    * [1.21-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.21.13.5/Containerfile), [1.21-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.21.13.5/Containerfile), [1.21.13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.21.13.5/Containerfile), [1.21.13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.21.13.5/Containerfile)
    
    * [1.22-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.22.12.4/Containerfile), [1.22-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.22.12.4/Containerfile), [1.22.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.22.12.4/Containerfile), [1.22.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.22.12.4/Containerfile)
    
    * [1.23-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.23.12/Containerfile), [1.23-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.23.12/Containerfile), [1.23.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.23.12/Containerfile), [1.23.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.23.12/Containerfile)
    
    * [1.24-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.24.9/Containerfile), [1.24-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.24.9/Containerfile), [1.24.9-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.24.9/Containerfile), [1.24.9-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.24.9/Containerfile)
    
    * [1-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [1-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [1.25-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [1.25-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [1.25.4-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [1.25.4-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/golang/1.25.4/Containerfile)
    

=== "License"

     [images/14.3/golang/1.25/LICENSE](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/golang/1.25/LICENSE)

    ```console
    --8<-- "images/14.3/golang/1.25/LICENSE"
    ```