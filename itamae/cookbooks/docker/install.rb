require 'daddy/itamae'

case os_version
when /rhel-6\.(.*?)/
  package 'epel-release' do
    user 'root'
  end

  package 'docker-io' do
    user 'root'
  end

  group 'docker' do
    user 'root'
  end

  execute "add user to docker group" do
    user 'root'
    command "usermod -aG docker #{ENV['USER']}"
    not_if "groups #{ENV['USER']} | grep -E \"\sdocker\""
  end

  local_ruby_block 'post install message' do
    block do
      message = I18n.t('itamae.messages.docker.after_install', :user => ENV['USER'])
      message.split("\n").map {|line| Itamae.logger.info line }
    end
    action :nothing
    subscribes :run, 'execute[add user to docker group]'
  end

  local_ruby_block 'post install message' do
    block do
      message = I18n.t('itamae.messages.docker.after_install', :user => ENV['USER'])
      ['', message.split("\n"), ''].flatten.map {|line| Itamae.logger.info line }
    end
    action :nothing
    subscribes :run, 'execute[add user to docker group]'
  end
when /rhel-7\.(.*?)/
  %w{ yum-utils device-mapper-persistent-data lvm2 }.each do |name|
    package name do
      user 'root'
    end
  end

  execute 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo' do
    user 'root'
    not_if 'test -e /etc/yum.repos.d/docker-ce.repo'
  end
  
  package 'docker-ce' do
    user 'root'
  end

  group 'docker' do
    user 'root'
  end
  
  execute "add user to docker group" do
    command "sudo usermod -a -G docker #{ENV['USER']} && newgrp docker"
    not_if "groups #{ENV['USER']} | grep -E \"\sdocker\""
  end
else
  raise "unsupported operating system: #{os_version}"
end

service 'docker' do
  action [:enable, :start]
  user 'root'
end
