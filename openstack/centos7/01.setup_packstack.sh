#!/bin/bash
#
# run as root
#

# cinder-volumes
dd if=/dev/zero of=/root/cinder.img bs=1024M count=8
losetup /dev/loop0 /root/cinder.img
parted -s /dev/loop0 'mklabel gpt'
parted -s /dev/loop0 'mkpart primary 0 -1'
parted -s /dev/loop0 'set 1 lvm on'
parted -s /dev/loop0 'print'
partprobe /dev/loop0
cat /proc/partitions
pvcreate -y -ff /dev/loop0p1
vgcreate -y -f cinder-volumes /dev/loop0p1

# environment
echo 'LANG=en_US.uft-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment
cat /etc/environment

# packstack
yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-mitaka/rdo-release-mitaka-5.noarch.rpm
cat /etc/yum.repos.d/rdo-release.repo
yum update -y
yum install -y openstack-packstack
