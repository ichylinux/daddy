#!/bin/bash

SCRIPT_BASE=`dirname $0`

sudo yum install java-1.7.0-openjdk
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins
sudo cp -f ${SCRIPT_BASE}/jenkins /etc/sysconfig/jenkins
sudo chown root:root /etc/sysconfig/jenkins
sudo chmod 600 /etc/sysconfig/jenkins
sudo mkdir -p /var/lib/jenkins/plugins
sudo chown jenkins:jenkins /var/lib/jenkins/plugins

if [ -d /etc/nginx/conf.d ]; then
  sudo cp -f ${SCRIPT_BASE}/nginx.conf /etc/nginx/conf.d/
fi
