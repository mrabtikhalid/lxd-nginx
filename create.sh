#!/bin/bash
echo "Creating the container..."
lxc launch images:debian/buster web-server
echo "Installing required packages for snap..."
lxc exec web-server -- apt install fuse squashfuse -y
echo "Installing snap deamon..."
lxc exec web-server -- apt install snapd -y
echo "Installing snap core..."
lxc exec web-server -- snap install core
echo "Installing certbot..."
lxc exec web-server -- snap install certbot --classic
echo "Installing nginx/curl/wget..."
lxc exec web-server -- apt install wget curl nginx -y
echo "Adding port forwarfing device for port 80 ..."
lxc config device add web-server myport80 proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
echo "Adding port forwarfing device for port 443 ..."
lxc config device add web-server myport443 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443
echo "Done"
