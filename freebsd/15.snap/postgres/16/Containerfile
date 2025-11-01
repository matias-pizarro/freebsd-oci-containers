#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ghcr.io/freebsd/freebsd-runtime:15.snap
RUN /usr/bin/env pkg upgrade -yr FreeBSD-base
RUN rm -f /usr/local/etc/pkg/repos/base.conf
COPY files/repos /usr/local/etc/pkg/repos

RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-utilities
RUN /usr/bin/env pkg install -yr FreeBSD bash
RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-zfs

RUN /usr/bin/env pkg install -yr FreeBSD \
    binutils \
    gcc13-devel \
    gmp \
    icu \
    libedit \
    libffi \
    liblz4 \
    libxml2 \
    llvm19 \
    lua53 \
    mpc \
    mpdecimal \
    mpfr \
    perl5 \
    python311 \
    readline \
    zstd

RUN /usr/bin/env pkg install -yr FreeBSD-base FreeBSD-locales

ENV PG_MAJOR 16
ENV PGDATA /var/db/postgres/data${PG_MAJOR}
ENV UNIX_SOCKET_DIRECTORIES /var/run/postgresql
VOLUME /var/db/postgres/data${PG_MAJOR}

RUN /usr/bin/env pkg install -yr FreeBSD \
    postgresql${PG_MAJOR}-server

RUN sysrc postgresql_enable="YES"
RUN sysrc postgresql_flags="-o '-k ${UNIX_SOCKET_DIRECTORIES}' -l ${PGDATA}/postgres.log -w -s -m fast"

RUN mkdir -p ${UNIX_SOCKET_DIRECTORIES} && chown postgres:postgres ${UNIX_SOCKET_DIRECTORIES}

RUN mkdir /docker-entrypoint-initdb.d && chown postgres:postgres /docker-entrypoint-initdb.d

COPY files/etc.login.conf /tmp/etc.login.conf
RUN cat /tmp/etc.login.conf >> /etc/login.conf \
    && cap_mkdb /etc/login.conf \
    && sysrc postgresql_login_class="postgres" \
    && pw user mod -L postgres -n postgres \
    && rm -f /tmp/etc.login.conf

RUN set -ex; \
    postgres --version

COPY docker-entrypoint.sh docker-ensure-initdb.sh /usr/local/bin/
RUN ln -s docker-ensure-initdb.sh /usr/local/bin/docker-enforce-initdb.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# We set the default STOPSIGNAL to SIGINT, which corresponds to what PostgreSQL
# calls "Fast Shutdown mode" wherein new connections are disallowed and any
# in-progress transactions are aborted, allowing PostgreSQL to stop cleanly and
# flush tables to disk.
#
# See https://www.postgresql.org/docs/current/server-shutdown.html for more details
# about available PostgreSQL server shutdown signals.
#
# See also https://www.postgresql.org/docs/current/server-start.html for further
# justification of this as the default value, namely that the example (and
# shipped) systemd service files use the "Fast Shutdown mode" for service
# termination.
#
STOPSIGNAL SIGINT
#
# An additional setting that is recommended for all users regardless of this
# value is the runtime "--stop-timeout" (or your orchestrator/runtime's
# equivalent) for controlling how long to wait between sending the defined
# STOPSIGNAL and sending SIGKILL.
#
# The default in most runtimes (such as Docker) is 10 seconds, and the
# documentation at https://www.postgresql.org/docs/current/server-start.html notes
# that even 90 seconds may not be long enough in many instances.

EXPOSE 5432
CMD ["postgres"]
