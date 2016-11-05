require 'daddy/itamae'

template '/etc/yum.repos.d/nginx.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

package 'nginx' do
  user 'root'
end

template '/etc/nginx/nginx.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

template '/etc/nginx/conf.d/default.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

service 'nginx' do
  user 'root'
  action :enable
end