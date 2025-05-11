file '/etc/yum.repos.d/nodesource-nodejs.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'yum clean all --enablerepo=nodesource-nodejs' do
  user 'root'
  action :nothing
  subscribes :run, "file[/etc/yum.repos.d/nodesource-nodejs.repo]", :immediately
end

package 'nodejs' do
  user 'root'
  version '18.20.8-1nodesource'
  options '--enablerepo=nodesource-nodejs'
end

file '/etc/yum.repos.d/yarn.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

package 'yarn' do
  user 'root'
  options '--enablerepo=yarn'
end
