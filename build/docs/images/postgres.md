# Postgres

The corresponding FreeBSD14.3p5-amd64 images are available on
[Github](https://github.com/matias-pizarro/freebsd-oci-containers/pkgs/container/freebsd-oci-containers%2Fpostgres),
[DockerHub]()
and
[Quay]().
CI/CD pipelines will soon add amd64/aarch64 support for 15.0, 14.snap, 15.snap and 16.snap.

=== "Image"

    ## Containerfile

    ```dockerfile title="images/14.3/postgres/18/Containerfile"
    --8<-- "images/14.3/postgres/18/Containerfile"
    ```

    ## Build the image

    ```console title="images/14.3/postgres/18/build.sh"
    --8<-- "images/14.3/postgres/18/build.sh:6"
    ```

    ## Test the image

    ```console title="images/14.3/postgres/18/test.sh"
    --8<-- "images/14.3/postgres/18/test.sh:6"
    ```

    ## Push the image

    ```console title="images/14.3/postgres/18/push.sh"
    --8<-- "images/14.3/postgres/18/push.sh:6"
    ```

    ## Run the full pipeline from building to pushing

    ```console title="images/14.3/postgres/18/run_pipeline.sh"
    --8<-- "images/14.3/postgres/18/run_pipeline.sh:6"
    ```

    ## Tags

    
    * [13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/13/Containerfile), [13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/13/Containerfile), [13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/13/Containerfile)
    
    * [14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/14/Containerfile), [14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/14/Containerfile), [14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/14/Containerfile)
    
    * [15-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/15/Containerfile), [15-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/15/Containerfile), [15-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/15/Containerfile)
    
    * [16-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/16/Containerfile), [16-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/16/Containerfile), [16-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/16/Containerfile)
    
    * [17-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/17/Containerfile), [17-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/17/Containerfile), [17-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/17/Containerfile)
    
    * [18-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile)
    
    * [13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/13/Containerfile)
    
    * [14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/14/Containerfile)
    
    * [15-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/15/Containerfile)
    
    * [16-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/16/Containerfile)
    
    * [17-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/17/Containerfile)
    
    * [18-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/18/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/18/Containerfile)
    
    * [13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/13/Containerfile), [13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/13/Containerfile)
    
    * [14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/14/Containerfile), [14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/14/Containerfile)
    
    * [15-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/15/Containerfile), [15-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/15/Containerfile)
    
    * [16-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/16/Containerfile), [16-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/16/Containerfile)
    
    * [17-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/17/Containerfile), [17-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/17/Containerfile)
    
    * [18-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile), [18-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile)
    
    * [13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/13/Containerfile)
    
    * [14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/14/Containerfile)
    
    * [15-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/15/Containerfile)
    
    * [16-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/16/Containerfile)
    
    * [17-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/17/Containerfile)
    
    * [18-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/18/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/18/Containerfile)
    
    * [13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/13/Containerfile), [13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/13/Containerfile)
    
    * [14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/14/Containerfile), [14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/14/Containerfile)
    
    * [15-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/15/Containerfile), [15-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/15/Containerfile)
    
    * [16-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/16/Containerfile), [16-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/16/Containerfile)
    
    * [17-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/17/Containerfile), [17-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/17/Containerfile)
    
    * [18-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile), [18-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile)
    

=== "Supported tags and respective Containerfile links"

    
    * [13-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/13/Containerfile), [13-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/13/Containerfile), [13-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/13/Containerfile)
    
    * [14-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/14/Containerfile), [14-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/14/Containerfile), [14-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/14/Containerfile)
    
    * [15-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/15/Containerfile), [15-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/15/Containerfile), [15-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/15/Containerfile)
    
    * [16-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/16/Containerfile), [16-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/16/Containerfile), [16-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/16/Containerfile)
    
    * [17-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/17/Containerfile), [17-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/17/Containerfile), [17-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/17/Containerfile)
    
    * [18-freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [18-freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [freebsd](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [freebsd14](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile), [freebsd14.3](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.3/postgres/18/Containerfile)
    
    * [13-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/13/Containerfile)
    
    * [14-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/14/Containerfile)
    
    * [15-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/15/Containerfile)
    
    * [16-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/16/Containerfile)
    
    * [17-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/17/Containerfile)
    
    * [18-freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/18/Containerfile), [freebsd14.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/14.snapshot/postgres/18/Containerfile)
    
    * [13-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/13/Containerfile), [13-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/13/Containerfile)
    
    * [14-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/14/Containerfile), [14-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/14/Containerfile)
    
    * [15-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/15/Containerfile), [15-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/15/Containerfile)
    
    * [16-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/16/Containerfile), [16-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/16/Containerfile)
    
    * [17-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/17/Containerfile), [17-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/17/Containerfile)
    
    * [18-freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile), [18-freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile), [freebsd15](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile), [freebsd15.0](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.0/postgres/18/Containerfile)
    
    * [13-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/13/Containerfile)
    
    * [14-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/14/Containerfile)
    
    * [15-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/15/Containerfile)
    
    * [16-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/16/Containerfile)
    
    * [17-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/17/Containerfile)
    
    * [18-freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/18/Containerfile), [freebsd15.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/15.snapshot/postgres/18/Containerfile)
    
    * [13-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/13/Containerfile), [13-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/13/Containerfile)
    
    * [14-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/14/Containerfile), [14-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/14/Containerfile)
    
    * [15-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/15/Containerfile), [15-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/15/Containerfile)
    
    * [16-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/16/Containerfile), [16-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/16/Containerfile)
    
    * [17-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/17/Containerfile), [17-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/17/Containerfile)
    
    * [18-freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile), [18-freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile), [freebsd16](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile), [freebsd16.snapshot](https://github.com/matias-pizarro/freebsd-oci-containers/blob/main/build/images/16.snapshot/postgres/18/Containerfile)
    