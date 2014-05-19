# coding: UTF-8

require 'rake'
require_relative 'task_helper'

namespace :dad do
  namespace :fluentd do

    desc "Fluentdをインストールします。"
    task :install do
      if Daddy.config.fluentd.nginx?
        nginx = File.join(Rails.root, 'tmp', 'fluentd', "#{app_name}_nginx.conf")
        FileUtils.mkdir_p(File.dirname(nginx))
        File.write(nginx, ERB.new(File.read(File.join(File.dirname(__FILE__), 'fluentd_nginx.conf.erb'))).result)
      else
        FileUtils.rm_f(nginx)
      end

      script = <<-EOF
#!/bin/bash

sudo rpm --import http://packages.treasure-data.com/redhat/RPM-GPG-KEY-td-agent
sudo cp -f #{File.join(File.dirname(__FILE__), 'fluentd.repo')} /etc/yum.repos.d/
sudo yum install td-agent
sudo gem install fluent-plugin-mongo

sudo cp -f #{File.join(File.dirname(__FILE__), 'fluentd.conf')} /etc/td-agent/td-agent.conf
sudo mkdir -p /etc/td-agent/conf.d

if [ -e #{nginx} ]; then
  sudo cp -f #{nginx} /etc/td-agent/conf.d
  sudo usermod -aG adm td-agent
fi

sudo /sbin/chkconfig td-agent on
if [ -e /var/run/td-agent/td-agent.pid ]; then
  sudo /etc/init.d/td-agent restart
else
  sudo /etc/init.d/td-agent start
fi
EOF
      tmpfile = File.join(Rails.root, 'tmp', 'dad-fluentd-install-' + Daddy::Utils::StringUtils.current_time + '.sh')
      File.write(tmpfile, ERB.new(script).result)
      
      unless ENV['DRY_RUN']
        fail unless system("bash #{tmpfile}")
      end
    end
  end
end
