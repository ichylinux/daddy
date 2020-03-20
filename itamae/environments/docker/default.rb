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
  command "sudo usermod -a -G docker ${USER} && newgrp docker"
  not_if "groups ${USER} | grep -E \"\sdocker\""
end

service 'docker' do
  action [:enable, :start]
  user 'root'
end
