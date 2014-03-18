# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :redis do

    desc "Redisをインストールします。"
    task :install do
      script = <<-EOF
#!/bin/bash

if [ -e /var/run/redis/redis.pid ]; then
  sudo /etc/init.d/redis stop
fi

sudo yum --enablerepo=epel install redis
sudo /sbin/chkconfig redis on
sudo /etc/init.d/redis start
EOF

      tmpfile = File.join(Rails.root, 'tmp', 'dad-redis-install-' + Daddy::Utils::StringUtils.current_time + '.sh')
      File.write(tmpfile, ERB.new(script).result)
      fail unless system("bash #{tmpfile}")
    end

  end
end
