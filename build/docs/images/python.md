# Python

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fpython),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

=== "Image"

    ## Containerfile

    ```dockerfile title="images/14.3/python/3.11/Containerfile"
    --8<-- "images/14.3/python/3.11/Containerfile"
    ```

    ## Build the image

    ```console title="images/14.3/python/3.11/build.sh"
    --8<-- "images/14.3/python/3.11/build.sh:6"
    ```

    ## Test the image

    ```console title="images/14.3/python/3.11/test.sh"
    --8<-- "images/14.3/python/3.11/test.sh:6"
    ```

    ## Push the image

    ```console title="images/14.3/python/3.11/push.sh"
    --8<-- "images/14.3/python/3.11/push.sh:6"
    ```

    ## Run the full pipeline from building to pushing

    ```console title="images/14.3/python/3.11/run_pipeline.sh"
    --8<-- "images/14.3/python/3.11/run_pipeline.sh:6"
    ```

    ## Tags

    
    * [3.10-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.10/Containerfile), [3.10-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.10/Containerfile), [3.10-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.10/Containerfile)
    
    * [3-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.12/Containerfile), [3.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.12/Containerfile), [3.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.12/Containerfile)
    
    * [3.13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.13/Containerfile), [3.13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.13/Containerfile), [3.13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.13/Containerfile)
    
    * [3.14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.14/Containerfile), [3.14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.14/Containerfile), [3.14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.14/Containerfile)
    
    * [3.10-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.10/Containerfile)
    
    * [3-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.11/Containerfile), [3.11-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.11/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.11/Containerfile)
    
    * [3.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.12/Containerfile)
    
    * [3.13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.13/Containerfile)
    
    * [3.14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.14/Containerfile)
    
    * [3.10-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.10/Containerfile), [3.10-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.10/Containerfile)
    
    * [3-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [3-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [3.11-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [3.11-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile)
    
    * [3.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.12/Containerfile), [3.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.12/Containerfile)
    
    * [3.13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.13/Containerfile), [3.13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.13/Containerfile)
    
    * [3.14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.14/Containerfile), [3.14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.14/Containerfile)
    
    * [3.10-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.10/Containerfile)
    
    * [3-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.11/Containerfile), [3.11-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.11/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.11/Containerfile)
    
    * [3.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.12/Containerfile)
    
    * [3.13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.13/Containerfile)
    
    * [3.14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.14/Containerfile)
    
    * [3.10-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.10/Containerfile), [3.10-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.10/Containerfile)
    
    * [3-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [3-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [3.11-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [3.11-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile)
    
    * [3.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.12/Containerfile), [3.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.12/Containerfile)
    
    * [3.13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.13/Containerfile), [3.13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.13/Containerfile)
    
    * [3.14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.14/Containerfile), [3.14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.14/Containerfile)
    

=== "Supported tags and respective Containerfile links"

    
    * [3.10-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.10/Containerfile), [3.10-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.10/Containerfile), [3.10-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.10/Containerfile)
    
    * [3-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [3.11-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.11/Containerfile)
    
    * [3.12-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.12/Containerfile), [3.12-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.12/Containerfile), [3.12-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.12/Containerfile)
    
    * [3.13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.13/Containerfile), [3.13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.13/Containerfile), [3.13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.13/Containerfile)
    
    * [3.14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.14/Containerfile), [3.14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.14/Containerfile), [3.14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/python/3.14/Containerfile)
    
    * [3.10-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.10/Containerfile)
    
    * [3-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.11/Containerfile), [3.11-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.11/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.11/Containerfile)
    
    * [3.12-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.12/Containerfile)
    
    * [3.13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.13/Containerfile)
    
    * [3.14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/python/3.14/Containerfile)
    
    * [3.10-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.10/Containerfile), [3.10-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.10/Containerfile)
    
    * [3-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [3-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [3.11-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [3.11-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.11/Containerfile)
    
    * [3.12-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.12/Containerfile), [3.12-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.12/Containerfile)
    
    * [3.13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.13/Containerfile), [3.13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.13/Containerfile)
    
    * [3.14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.14/Containerfile), [3.14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/python/3.14/Containerfile)
    
    * [3.10-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.10/Containerfile)
    
    * [3-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.11/Containerfile), [3.11-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.11/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.11/Containerfile)
    
    * [3.12-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.12/Containerfile)
    
    * [3.13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.13/Containerfile)
    
    * [3.14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/python/3.14/Containerfile)
    
    * [3.10-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.10/Containerfile), [3.10-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.10/Containerfile)
    
    * [3-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [3-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [3.11-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [3.11-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.11/Containerfile)
    
    * [3.12-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.12/Containerfile), [3.12-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.12/Containerfile)
    
    * [3.13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.13/Containerfile), [3.13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.13/Containerfile)
    
    * [3.14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.14/Containerfile), [3.14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/python/3.14/Containerfile)
    