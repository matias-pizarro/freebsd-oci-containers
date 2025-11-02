#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ghcr.io/matias-pizarro/freebsd-oci-containers/freebsd-zfs:14.snap

RUN set -eux; \
    /usr/bin/env pkg install -yr FreeBSD \
    databases/py-gdbm@py314 \
    databases/py-sqlite3@py314 \
    devel/py-pip@py314 \
    devel/py-setuptools@py314 \
    devel/py-wheel@py314 \
    lang/python314 \
    x11-toolkits/py-tkinter@py314; \
    /bin/rm -f /var/cache/pkg/*

RUN set -eux; \
    /bin/ln -s /usr/local/bin/pip /usr/local/bin/pip3; \
    /bin/ln -s /usr/local/bin/pip /usr/local/bin/pip3.14;

RUN set -eux; \
    for src in idle3.14 pydoc3.14 python3.14 python3.14-config; do \
        dst="$(echo "$src" | tr -d .14)"; \
        [ -s "/usr/local/bin/$src" ]; \
        [ ! -e "/usr/local/bin/$dst" ]; \
        ln -sv "$src" "/usr/local/bin/$dst"; \
    done

RUN set -eux; \
    for src in idle3 pydoc3 python3 python3-config; do \
        dst="$(echo "$src" | tr -d 3)"; \
        [ -s "/usr/local/bin/$src" ]; \
        [ ! -e "/usr/local/bin/$dst" ]; \
        ln -sv "$src" "/usr/local/bin/$dst"; \
    done

RUN set -eux; \
    export PYTHONDONTWRITEBYTECODE=1; \
    python3 --version; \
    pip3 --version

CMD ["python3"]
