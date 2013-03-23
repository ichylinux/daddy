#!/bin/bash

echo "ライブラリのインストール"
  yum install httpd-devel libxslt-devel libxml2-devel java-1.7.0-openjdk qt-webkit-devel Xvfb

echo "リポジトリ情報を取得"
  wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
  rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

echo "Jenkinsをインストール"
  yum install jenkins
