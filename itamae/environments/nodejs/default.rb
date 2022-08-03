template '/etc/yum.repos.d/nodesource-el7.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'yum clean all --enablerepo=nodesource' do
  user 'root'
  action :nothing
  subscribes :run, "template[/etc/yum.repos.d/nodesource-el7.repo]", :immediately
end

template '/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

package 'nodejs' do
  user 'root'
  version "16.16.0-1nodesource"
  options '--enablerepo=nodesource'
end

template '/etc/yum.repos.d/yarn.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

package 'yarn' do
  user 'root'
end
