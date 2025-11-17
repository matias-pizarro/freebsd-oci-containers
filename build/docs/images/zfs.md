# ZFS

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Ffreebsd-zfs),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.


=== "Containerfile"

     [images/14.3/zfs/runtime/Containerfile](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/zfs/runtime/Containerfile)

    ```dockerfile
    --8<-- "images/14.3/zfs/runtime/Containerfile"
    ```

=== "Build"

     [images/14.3/zfs/runtime/build.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/zfs/runtime/build.sh)

    ```console
    --8<-- "images/14.3/zfs/runtime/build.sh:6"
    ```

=== "Test"

     [images/14.3/zfs/runtime/test.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/zfs/runtime/test.sh)

    ```console
    --8<-- "images/14.3/zfs/runtime/test.sh:6:-2"
    ```

=== "Push"

     [images/14.3/zfs/runtime/push.sh](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/zfs/runtime/push.sh)

    ```console
    --8<-- "images/14.3/zfs/runtime/push.sh:6"
    ```

=== "Tags"

    *Supported tags and respective Containerfile links*

    
    * [static](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/static/Containerfile), [static-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/static/Containerfile), [static-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/static/Containerfile)
    
    * [dynamic](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/dynamic/Containerfile), [dynamic-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/dynamic/Containerfile), [dynamic-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/dynamic/Containerfile)
    
    * [latest](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/runtime/Containerfile), [14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/runtime/Containerfile), [14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/runtime/Containerfile), [runtime](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/runtime/Containerfile), [runtime-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/runtime/Containerfile), [runtime-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/zfs/runtime/Containerfile)
    
    * [static-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/zfs/static/Containerfile)
    
    * [dynamic-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/zfs/dynamic/Containerfile)
    
    * [14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/zfs/runtime/Containerfile), [runtime-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/zfs/runtime/Containerfile)
    
    * [static-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/static/Containerfile), [static-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/static/Containerfile)
    
    * [dynamic-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/dynamic/Containerfile), [dynamic-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/dynamic/Containerfile)
    
    * [15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/runtime/Containerfile), [15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/runtime/Containerfile), [runtime-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/runtime/Containerfile), [runtime-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/zfs/runtime/Containerfile)
    
    * [static-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/zfs/static/Containerfile)
    
    * [dynamic-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/zfs/dynamic/Containerfile)
    
    * [15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/zfs/runtime/Containerfile), [runtime-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/zfs/runtime/Containerfile)
    
    * [static-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/static/Containerfile), [static-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/static/Containerfile)
    
    * [dynamic-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/dynamic/Containerfile), [dynamic-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/dynamic/Containerfile)
    
    * [16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/runtime/Containerfile), [16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/runtime/Containerfile), [runtime-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/runtime/Containerfile), [runtime-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/zfs/runtime/Containerfile)
    

=== "License"

     [images/14.3/zfs/runtime/LICENSE](https://github.com/matias-pizarro/freebsd-oci-containers/tree/main/build/images/14.3/zfs/runtime/LICENSE)

    ```console
    --8<-- "images/14.3/zfs/runtime/LICENSE"
    ```