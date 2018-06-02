template '/etc/yum.repos.d/nodesource.repo' do
  user 'root'
end

package 'nodejs' do
  user 'root'
end
