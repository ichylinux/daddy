template '/etc/yum.repos.d/nodesource-el7.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

template '/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

package 'nodejs' do
  user 'root'
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
