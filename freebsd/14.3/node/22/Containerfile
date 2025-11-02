FROM ghcr.io/matias-pizarro/freebsd-oci-containers/freebsd-zfs:14.3

RUN echo "node:1000:::0:0:Node user:/home/node:/usr/local/bin/bash:" | adduser -f -
RUN /usr/bin/env pkg install -yr FreeBSD \
    brotli \
    c-ares \
    ca_root_nss \
    gmake \
    icu \
    libffi \
    libnghttp2 \
    libnghttp3 \
    libngtcp2 \
    libuv \
    mpdecimal \
    python311 \
    readline \
    simdjson \
    && rm -f /var/cache/pkg/*

RUN /usr/bin/env pkg install -yr FreeBSD archivers/liblz4 archivers/zstd \
    && rm -f /var/cache/pkg/*

RUN /usr/bin/env pkg install -yr FreeBSD www/node22 \
    www/npm-node22 \
    www/yarn-node22 \
    && rm -f /var/cache/pkg/*

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]
