#!/bin/sh

/usr/bin/sed -i '' 's|##-##NGINX_PORT##-##|'${NGINX_PORT}'|g' /usr/local/etc/nginx/nginx.conf
/usr/sbin/service nginx start

export EXT_IP=$(ifconfig eth0 2>& 1 | grep inet | awk '{print $2}')
echo "========================================"
echo "|| Listening on port ${NGINX_PORT} at ${EXT_IP} || "
echo "========================================"
echo ""
echo "Errors will appear here:"
echo ""

tail -F /var/log/nginx/error.log
