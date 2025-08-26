file '/etc/yum.repos.d/nodesource-nodejs.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'place /etc/yum.repos.d/nodesource-nodejs.repo' do
  user 'root'
  command <<-EOF
    set -eu
    sudo cp -f #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs.repo')} /etc/yum.repos.d/nodesource-nodejs.repo
    sudo chmod 644 /etc/yum.repos.d/nodesource-nodejs.repo
  EOF
  not_if "diff #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs.repo')} /etc/yum.repos.d/nodesource-nodejs.repo"
end

execute 'yum clean all --enablerepo=nodesource-nodejs' do
  user 'root'
  action :nothing
  subscribes :run, "execute[place /etc/yum.repos.d/nodesource-nodejs.repo]", :immediately
end

package 'nodejs' do
  user 'root'
  version '22.18.0-1nodesource'
  options '--enablerepo=nodesource-nodejs'
end

execute 'place /etc/yum.repos.d/yarn.repo' do
  user 'root'
  command <<-EOF
    set -eu
    sudo cp -f #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/yarn.repo')} /etc/yum.repos.d/yarn.repo
    sudo chmod 644 /etc/yum.repos.d/yarn.repo
  EOF
  not_if "diff #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/yarn.repo')} /etc/yum.repos.d/yarn.repo"
end

execute 'yum clean all --enablerepo=yarn' do
  user 'root'
  action :nothing
  subscribes :run, "execute[place /etc/yum.repos.d/yarn.repo]", :immediately
end

package 'yarn' do
  user 'root'
  options '--enablerepo=yarn'
end
