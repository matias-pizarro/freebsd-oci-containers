FROM ghcr.io/matias-pizarro/freebsd-oci-containers/freebsd-zfs:16.snap

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

ENV NODE_VERSION=0.0.0

RUN /usr/bin/env pkg install -yr FreeBSD www/node24 \
    www/npm-node24 \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    # smoke tests
    && node --version \
    && npm --version \
    && rm -f /var/cache/pkg/*

ENV YARN_VERSION=0.0.0

RUN /usr/bin/env pkg install -yr FreeBSD www/yarn-node24 \
    # smoke test
    && yarn --version \
    && rm -f /var/cache/pkg/*

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]
