# git clone git@gitlab.com:bergblume/podman-caddy-on-freebsd.git
(...)
# cd podman-caddy-on-freebsd
# mkdir -p data
# cp -p Caddyfile index.html data/
# podman run -d --rm --name caddy-server -p 8080:80 -v ./data:/data localhost/caddy:latest caddy run --config /data/Caddyfile
(...)
# podman ps
CONTAINER ID  IMAGE                   COMMAND               CREATED       STATUS        PORTS                 NAMES
015cc3232888  localhost/caddy:latest  caddy run --confi...  1 second ago  Up 2 seconds  0.0.0.0:8080->80/tcp  caddy-server

# podman port caddy-server
80/tcp -> 0.0.0.0:8080

# podman exec -ti caddy-server ifconfig eth0 inet
eth0: flags=1008843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST,LOWER_UP> metric 0 mtu 1500
        options=8<VLAN_MTU>
        inet 10.88.0.9 netmask 0xffff0000 broadcast 10.88.255.255

# IP=$(podman exec -ti caddy-server ifconfig eth0 inet | grep inet | awk '{print $2}')
# ping -c 2 ${IP}
PING 10.88.0.9 (10.88.0.9): 56 data bytes
64 bytes from 10.88.0.9: icmp_seq=0 ttl=64 time=0.126 ms
64 bytes from 10.88.0.9: icmp_seq=1 ttl=64 time=0.198 ms

--- 10.88.0.9 ping statistics ---
2 packets transmitted, 2 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 0.126/0.162/0.198/0.036 ms

# pfctl -s nat
nat on ue0 inet from <cni-nat> to any -> (ue0) round-robin
nat-anchor "cni-rdr/*" all
rdr-anchor "cni-rdr/*" all

# pfctl -t cni-nat -T show
   10.88.0.9

# curl -v4 ${IP}:80
*   Trying 10.88.0.9:80...
* Connected to 10.88.0.9 (10.88.0.9) port 80
* using HTTP/1.x
> GET / HTTP/1.1
> Host: 10.88.0.9
> User-Agent: curl/8.10.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Accept-Ranges: bytes
< Content-Length: 59
< Content-Type: text/html; charset=utf-8
< Etag: "d4o16tm8frq01n"
< Last-Modified: Sat, 05 Oct 2024 16:59:38 GMT
< Server: Caddy
< Vary: Accept-Encoding
< Date: Thu, 10 Oct 2024 13:08:16 GMT
< 
<html>
<body>
<h1>FreeBSD Caddy Test!</h1>
</body>
</html>
* Connection #0 to host 10.88.0.9 left intact

# curl -v4 --connect-timeout 5 localhost:8080
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying 127.0.0.1:8080...
* ipv4 connect timeout after 5000ms, move on!
* Failed to connect to localhost port 8080 after 5002 ms: Timeout was reached
* closing connection #0
curl: (28) Failed to connect to localhost port 8080 after 5002 ms: Timeout was reached

# podman stop caddy-server
