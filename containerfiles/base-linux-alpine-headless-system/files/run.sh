#!/bin/sh

export EXT_IP=$(ip address 2>& 1 | grep inet | grep eth0 | awk '{print $2}' | awk -F '/' '{print $1}')
echo "========================================"
echo "|| Running at ${EXT_IP} || "
echo "========================================"
echo ""
echo "/var/log/messages will appear here:"
echo ""

while true; do sleep 3600; done
