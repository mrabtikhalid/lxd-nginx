#!/bin/bash
lxc launch images:debian/buster web-server
lxc exec web-server -- apt install fuse squashfuse -y
lxc exec web-server -- apt install snapd -y
lxc exec web-server -- snap install core
lxc exec web-server -- snap install certbot --classic
lxc exec web-server -- apt install wget curl nginx -y
lxc config device add web-server myport80 proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
lxc config device add web-server myport443 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443
