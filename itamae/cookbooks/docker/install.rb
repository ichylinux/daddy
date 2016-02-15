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
  template '/etc/yum.repos.d/docker.repo' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end
  
  package 'docker-engine' do
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
