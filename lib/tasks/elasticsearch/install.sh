#!/bin/bash

SCRIPT_BASE=`dirname $0`
VERSION="1.4.0"
URL=https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${VERSION}.tar.gz
URL_SW=https://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master

mkdir -p tmp
pushd tmp
  if [ -e elasticsearch-${VERSION}.tar.gz ]; then
    echo "elasticsearch-${VERSION}.tar.gz はダウンロード済みです。"
  else
    wget ${URL}
  fi

  if [ -e elasticsearch-servicewrapper.tar.gz ]; then
    echo "elasticsearch-servicewrapper.tar.gz はダウンロード済みです。"
  else
    wget ${URL_SW} -O elasticsearch-servicewrapper.tar.gz
  fi

  rm -Rf elasticsearch-${VERSION}
  tar zxf elasticsearch-${VERSION}.tar.gz
  sudo rm -Rf /opt/elasticsearch-${VERSION}
  sudo mv elasticsearch-${VERSION} /opt/
  sudo ln -snf /opt/elasticsearch-${VERSION} /opt/elasticsearch
  sudo cp -f elasticsearch.yml /opt/elasticsearch/config/
  
  rm -Rf elasticsearch-elasticsearch-servicewrapper*
  tar zxf elasticsearch-servicewrapper.tar.gz
  sudo mv elasticsearch-elasticsearch-servicewrapper*/service /opt/elasticsearch/bin/
  sudo cp -f elasticsearch.conf /opt/elasticsearch/bin/service
  sudo /opt/elasticsearch/bin/service/elasticsearch remove
  sudo /opt/elasticsearch/bin/service/elasticsearch install
  sudo chkconfig elasticsearch on
popd
