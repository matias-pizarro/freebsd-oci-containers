#!/usr/bin/env bash
set -Eeo pipefail

service stunnel start
service varnishlog start
# service varnishd start

# tail -F /var/log/varnish/varnish.log

varnishd -F -j none \
    -P /var/run/varnishd.pid \
    -a :80 \
    -T localhost:81 \
    -f /usr/local/etc/varnish/pkg.vcl \
    -s file,/var/cache/pkg_cache/varnish/varnish.cache,50G,2M,sequential \
    -h critbit
