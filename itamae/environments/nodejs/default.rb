template '/etc/yum.repos.d/nodesource-el7.repo' do
  user 'root'
end

template '/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL' do
  user 'root'
end

package 'nodejs' do
  user 'root'
end

template '/etc/yum.repos.d/yarn.repo' do
  user 'root'
end

package 'yarn' do
  user 'root'
end
