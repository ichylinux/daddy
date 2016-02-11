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
  raise "サポートしていないOSバージョンです。#{os_version}"
end

service 'docker' do
  action [:enable, :start]
  user 'root'
end

execute 'add user to docker group' do
  command "usermod -aG docker #{ENV['USER']}"
  user 'root'
  not_if 'grep -E "docker:.*:ichy" /etc/group'
end