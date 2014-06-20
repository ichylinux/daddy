#!/bin/bash

SCRIPT_BASE=`dirname $0`
export RAILS_ENV=$1
export RAILS_ROOT=$2

# stop god
  if [ -e /var/run/god.pid ]; then
    sudo /etc/init.d/god stop
  fi

# install
  sudo gem install god --no-ri --no-rdoc

# init.d
  sudo cp -f ${SCRIPT_BASE}/god /etc/init.d/god
  sudo chown root:root /etc/init.d/god
  sudo chmod 755 /etc/init.d/god

# master.conf
  sudo mkdir -p /etc/god
  sudo cp -f ${SCRIPT_BASE}/master.conf /etc/god/master.conf
  sudo chown root:root /etc/god/master.conf
  sudo chmod 644 /etc/god/master.conf

# logrotate
  sudo cp -f ${SCRIPT_BASE}/logrotate /etc/logrotate.d/god
  sudo chown root:root /etc/logrotate.d/god
  sudo chmod 644 /etc/logrotate.d/god

# service
  sudo /sbin/chkconfig god on

# start
  sudo /etc/init.d/god start
