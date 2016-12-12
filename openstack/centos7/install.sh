#!/bin/bash
#
# run as root
#

# disable ipv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
cat /proc/sys/net/ipv6/conf/all/disable_ipv6

