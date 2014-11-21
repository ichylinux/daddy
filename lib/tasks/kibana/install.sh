#!/bin/bash

SCRIPT_BASE=`dirname $0`
VERSION=$1

sudo rm -Rf /opt/kibana-${VERSION}
sudo mv tmp/kibana-${VERSION} /opt/
sudo ln -snf /opt/kibana-${VERSION} /opt/kibana

cp -f tmp/config.js /opt/kibana/
sudo cp -f tmp/nginx/kibana.conf /etc/nginx/conf.d/servers/
