#!/bin/bash
#
# run as root
#

# sudo
sed -i "s/\(^Defaults.*secure_path.*=\).*/\1 \/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/" /etc/sudoers

# disable ipv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
cat /proc/sys/net/ipv6/conf/all/disable_ipv6

# network
systemctl stop NetworkManager
systemctl disable NetworkManager
#systemctl stop firewalld
#systemctl disable firewalld

# selinux
sudo sed -i "s/\(^SELINUX=\).*/\1disabled/" /etc/selinux/config

# reboot
echo 'now you need to reboot'
