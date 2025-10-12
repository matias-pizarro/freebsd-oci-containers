FROM ghcr.io/freebsd/freebsd-runtime:16.snap@sha256:06265958eb908b3a32a2a4e1d5a9c1d1e1ca0414f3af0f203ff66376abed089d
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
RUN /usr/bin/env pkg install -yr FreeBSD www/node20 www/npm-node20 www/yarn-node20

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]
