#!/bin/bash

SCRIPT_BASE=`dirname $0`
VERSION="3.1.0"

mkdir -p tmp
pushd tmp
  if [ -e kibana-${VERSION}.tar.gz ]; then
    echo "kibana-${VERSION}.tar.gz はダウンロード済みです。"
  else
    wget https://download.elasticsearch.org/kibana/kibana/kibana-${VERSION}.tar.gz
  fi

  tar zxf kibana-${VERSION}.tar.gz
  sudo rm -Rf /opt/kibana-${VERSION}
  sudo mv kibana-${VERSION} /opt/
  sudo ln -snf /opt/kibana-${VERSION} /opt/kibana
popd

cp -f ${SCRIPT_BASE}/config.js /opt/kibana/
