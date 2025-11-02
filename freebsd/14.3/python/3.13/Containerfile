#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ghcr.io/matias-pizarro/freebsd-oci-containers/freebsd-zfs:14.3

RUN set -eux; \
    /usr/bin/env pkg install -yr FreeBSD \
    databases/py-gdbm@py313 \
    databases/py-sqlite3@py313 \
    devel/py-pip@py313 \
    devel/py-setuptools@py313 \
    devel/py-wheel@py313 \
    lang/python313 \
    x11-toolkits/py-tkinter@py313; \
    /bin/rm -f /var/cache/pkg/*

RUN set -eux; \
    /bin/ln -s /usr/local/bin/pip /usr/local/bin/pip3; \
    /bin/ln -s /usr/local/bin/pip /usr/local/bin/pip3.13;

RUN set -eux; \
    for src in idle3.13 pydoc3.13 python3.13 python3.13-config; do \
        dst="$(echo "$src" | tr -d .13)"; \
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
