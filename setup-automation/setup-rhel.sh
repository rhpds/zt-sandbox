#!/bin/bash

# install the packages
dnf install -y --releasever=10 --installroot=$scratchmnt redhat-release
dnf install -y --setopt=reposdir=/etc/yum.repos.d \
      --installroot=$scratchmnt \
      --setopt=cachedir=/var/cache/dnf httpd

# Enable cockpit functionality in showroom.
dnf -y remove tlog cockpit-session-recording
echo "[WebService]" > /etc/cockpit/cockpit.conf
echo "Origins = https://cockpit-${GUID}.${DOMAIN}" >> /etc/cockpit/cockpit.conf
echo "AllowUnencrypted = true" >> /etc/cockpit/cockpit.conf
systemctl enable --now cockpit.socket
