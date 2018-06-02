template '/etc/yum.repos.d/nodesource.repo' do
  user 'root'
end

template '/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL' do
  user 'root'
end

package 'nodejs' do
  user 'root'
end
