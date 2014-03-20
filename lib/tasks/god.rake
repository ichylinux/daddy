# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :god do

    desc "Godをインストールします。"
    task :install do
      script = <<-EOF
#!/bin/bash

if [ -e /var/run/god.pid ]; then
  sudo /etc/init.d/god stop
fi

sudo gem install god
sudo cp -f #{File.join(File.dirname(__FILE__), 'god')} /etc/init.d/god
sudo chown root:root /etc/init.d/god
sudo chmod 755 /etc/init.d/god

sudo cp -f #{File.join(File.dirname(__FILE__), 'god.logrotate')} /etc/logrotate.d/god
sudo chown root:root /etc/logrotate.d/god
sudo chmod 644 /etc/logrotate.d/god

sudo /sbin/chkconfig god on
sudo /etc/init.d/god start
EOF

      tmpfile = File.join(Rails.root, 'tmp', 'dad-god-install-' + Daddy::Utils::StringUtils.current_time + '.sh')
      File.write(tmpfile, ERB.new(script).result)
      fail unless system("bash #{tmpfile}")
    end

  end
end
