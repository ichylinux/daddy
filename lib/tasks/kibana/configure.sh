#!/bin/bash

SCRIPT_BASE=`dirname $0`
VERSION=$1

mkdir -p tmp
pushd tmp
  if [ -e kibana-${VERSION}.tar.gz ]; then
    echo "kibana-${VERSION}.tar.gz はダウンロード済みです。"
  else
    wget https://download.elasticsearch.org/kibana/kibana/kibana-${VERSION}.tar.gz
  fi

  rm -Rf kibana-${VERSION}
  tar zxf kibana-${VERSION}.tar.gz
popd
