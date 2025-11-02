#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ghcr.io/matias-pizarro/freebsd-oci-containers/freebsd-zfs:16.snap

RUN set -eux; \
    /usr/bin/env pkg install -yr FreeBSD \
    databases/py-gdbm@py312 \
    databases/py-sqlite3@py312 \
    devel/py-pip@py312 \
    devel/py-setuptools@py312 \
    devel/py-wheel@py312 \
    lang/python312 \
    x11-toolkits/py-tkinter@py312; \
    /bin/rm -f /var/cache/pkg/*

RUN set -eux; \
    /bin/ln -s /usr/local/bin/pip /usr/local/bin/pip3; \
    /bin/ln -s /usr/local/bin/pip /usr/local/bin/pip3.12;

RUN set -eux; \
    for src in idle3.12 pydoc3.12 python3.12 python3.12-config; do \
        dst="$(echo "$src" | tr -d .12)"; \
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
