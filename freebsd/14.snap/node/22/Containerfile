FROM ghcr.io/freebsd/freebsd-runtime:14.snap
RUN /usr/bin/env pkg upgrade -yr FreeBSD-base
RUN rm -f /usr/local/etc/pkg/repos/base.conf
COPY files/repos /usr/local/etc/pkg/repos

RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-utilities
RUN /usr/bin/env pkg install -yr FreeBSD bash
RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-zfs

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
    simdjson
RUN /usr/bin/env pkg install -yr FreeBSD \
    liblz4 \
    zstd
RUN /usr/bin/env pkg install -yr FreeBSD www/node22 www/npm-node22 www/yarn-node22

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]
