#!/bin/sh

/usr/sbin/service nginx start

export EXT_IP=$(ifconfig eth0 2>& 1 | grep inet | awk '{print $2}')
echo "========================================"
echo "|| Listening on port 80 at ${EXT_IP} || "
echo "========================================"
echo ""
echo "Errors will appear here:"
echo ""

tail -F /var/log/nginx/error.log
