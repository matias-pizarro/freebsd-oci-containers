#!/bin/sh

export EXT_IP=$(ifconfig eth0 2>& 1 | grep inet | awk '{print $2}')
echo "========================================"
echo "|| Running at ${EXT_IP} || "
echo "========================================"
echo ""
echo "/var/log/messages will appear here:"
echo ""

tail -F /var/log/messages
