FROM ghcr.io/freebsd/freebsd-runtime:14.3
RUN /usr/bin/env pkg upgrade -yr FreeBSD-base
RUN rm -f /usr/local/etc/pkg/repos/base.conf
COPY files/repos /usr/local/etc/pkg/repos

RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-utilities \
    && rm -f /var/cache/pkg/*
RUN /usr/bin/env pkg install -yr FreeBSD bash \
    && rm -f /var/cache/pkg/*
RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-zfs \
    && rm -f /var/cache/pkg/*

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

RUN /usr/bin/env pkg install -yr FreeBSD www/node20 \
    www/npm-node20 \
    www/yarn-node20 \
    && rm -f /var/cache/pkg/*

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]
