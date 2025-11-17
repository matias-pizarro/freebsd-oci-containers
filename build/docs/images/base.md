# Base

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Ffreebsd-base),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

=== "Image"

    ## Containerfile

    ```dockerfile title="images/14.3/base/runtime/Containerfile"
    --8<-- "images/14.3/base/runtime/Containerfile"
    ```

    ## Build the image

    ```console title="images/14.3/base/runtime/build.sh"
    --8<-- "images/14.3/base/runtime/build.sh:6"
    ```

    ## Test the image

    ```console title="images/14.3/base/runtime/test.sh"
    --8<-- "images/14.3/base/runtime/test.sh:6"
    ```

    ## Push the image

    ```console title="images/14.3/base/runtime/push.sh"
    --8<-- "images/14.3/base/runtime/push.sh:6"
    ```

    ## Run the full pipeline from building to pushing

    ```console title="images/14.3/base/runtime/run_pipeline.sh"
    --8<-- "images/14.3/base/runtime/run_pipeline.sh:6"
    ```

    ## Tags

    
    * [static](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/static/Containerfile), [static-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/static/Containerfile), [static-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/static/Containerfile)
    
    * [dynamic](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/dynamic/Containerfile), [dynamic-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/dynamic/Containerfile), [dynamic-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/dynamic/Containerfile)
    
    * [latest](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [runtime](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [runtime-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [runtime-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile)
    
    * [static-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/static/Containerfile)
    
    * [dynamic-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/dynamic/Containerfile)
    
    * [14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/runtime/Containerfile), [runtime-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/runtime/Containerfile)
    
    * [static-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/static/Containerfile), [static-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/static/Containerfile)
    
    * [dynamic-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/dynamic/Containerfile), [dynamic-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/dynamic/Containerfile)
    
    * [15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile), [15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile), [runtime-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile), [runtime-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile)
    
    * [static-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/static/Containerfile)
    
    * [dynamic-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/dynamic/Containerfile)
    
    * [15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/runtime/Containerfile), [runtime-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/runtime/Containerfile)
    
    * [static-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/static/Containerfile), [static-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/static/Containerfile)
    
    * [dynamic-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/dynamic/Containerfile), [dynamic-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/dynamic/Containerfile)
    
    * [16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile), [16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile), [runtime-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile), [runtime-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile)
    

=== "Supported tags and respective Containerfile links"

    
    * [static](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/static/Containerfile), [static-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/static/Containerfile), [static-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/static/Containerfile)
    
    * [dynamic](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/dynamic/Containerfile), [dynamic-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/dynamic/Containerfile), [dynamic-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/dynamic/Containerfile)
    
    * [latest](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [runtime](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [runtime-14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile), [runtime-14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/base/runtime/Containerfile)
    
    * [static-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/static/Containerfile)
    
    * [dynamic-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/dynamic/Containerfile)
    
    * [14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/runtime/Containerfile), [runtime-14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/base/runtime/Containerfile)
    
    * [static-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/static/Containerfile), [static-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/static/Containerfile)
    
    * [dynamic-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/dynamic/Containerfile), [dynamic-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/dynamic/Containerfile)
    
    * [15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile), [15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile), [runtime-15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile), [runtime-15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/base/runtime/Containerfile)
    
    * [static-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/static/Containerfile)
    
    * [dynamic-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/dynamic/Containerfile)
    
    * [15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/runtime/Containerfile), [runtime-15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/base/runtime/Containerfile)
    
    * [static-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/static/Containerfile), [static-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/static/Containerfile)
    
    * [dynamic-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/dynamic/Containerfile), [dynamic-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/dynamic/Containerfile)
    
    * [16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile), [16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile), [runtime-16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile), [runtime-16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/base/runtime/Containerfile)
    