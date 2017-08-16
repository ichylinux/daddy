require 'daddy/itamae'

case os_version
when /rhel-6\.(.*?)/
  package 'epel-release' do
    user 'root'
  end

  package 'docker-io' do
    user 'root'
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
else
  raise "unsupported operating system: #{os_version}"
end

group 'docker' do
  user 'root'
end

execute "usermod -aG docker #{ENV['USER']}" do
  user 'root'
  not_if "groups #{ENV['USER']} | grep -E \"\sdocker\""
end

service 'docker' do
  action [:enable, :start]
  user 'root'
end
