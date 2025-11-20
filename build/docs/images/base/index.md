---
icon: simple/freebsd
---

# :simple-freebsd:{ .freebsd } Base

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Ffreebsd-base),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.



=== "Containerfile"

     images/14.3/base/runtime/Containerfile [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/base/runtime/Containerfile"
    ```

=== "Build"

     images/14.3/base/runtime/build.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/build.sh)

    ```console
    --8<-- "images/14.3/base/runtime/build.sh:6"
    ```

=== "Test"

     images/14.3/base/runtime/test.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/test.sh)

    ```console
    --8<-- "images/14.3/base/runtime/test.sh:6:-2"
    ```

=== "Push"

     images/14.3/base/runtime/push.sh [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/push.sh)

    ```console
    --8<-- "images/14.3/base/runtime/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [static](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [static-14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [static-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [dynamic](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [dynamic-14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [dynamic-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [latest](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-14](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [static-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [dynamic-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [static-15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [static-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [dynamic-15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [dynamic-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-15](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [static-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [dynamic-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [static-16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [static-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [dynamic-16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [dynamic-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    
    * [16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-16](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile), [runtime-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/Containerfile)
    

=== "License"

     images/14.3/base/runtime/LICENSE [:simple-github:](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/base/runtime/LICENSE)

    ```console
    --8<-- "images/14.3/base/runtime/LICENSE"
    ```