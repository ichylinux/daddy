#!/bin/bash

echo "既にGodが起動していたら停止します。"
  if [ -e /var/run/god.pid ]; then
    sudo /etc/init.d/god stop
  fi

echo "Godをインストールします。"
  sudo gem install god

echo "Godの起動スクリプトを /etc/init.d/god に配置します。"
  sudo cp -f script/god/god /etc/init.d/god
  sudo chown root:root /etc/init.d/god
  sudo chmod 755 /etc/init.d/god

echo "Godの設定ファイルを /etc/god/madai.god に配置します。"
  export RAILS_ENV=$1
  export RAILS_ROOT=$2

  sudo mkdir -p /etc/god
  erb -T - script/god/madai.god.erb > tmp/madai.god 
  sudo cp -f tmp/madai.god /etc/god/madai.god
  sudo chown -R root:root /etc/god
  sudo chmod 755 /etc/god
  sudo chmod -R 644 /etc/god/*

  unset RAILS_ENV
  unset RAILS_ROOT

echo "Godのログロテート設定を /etc/logrotate.d/god に配置します。"
  sudo cp -f script/god/logrotate /etc/logrotate.d/god
  sudo chown root:root /etc/logrotate.d/god
  sudo chmod 644 /etc/logrotate.d/god

echo "サービスの自動起動設定を行います。"
  sudo /sbin/chkconfig god on

echo "Godを起動します。"
  if [ -z ${NO_START} ]; then
    NO_START=0
  fi

  if [ ${NO_START} -ne 1 ]; then
    sudo /etc/init.d/god start
  fi
