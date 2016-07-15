require 'daddy/itamae'

service 'god' do
  user 'root'
  action :stop
end

gem_package 'god' do
  user 'root'
end

template '/etc/init.d/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

directory '/etc/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

template '/etc/god/master.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

template '/etc/logrotate.d/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

service 'god' do
  user 'root'
  action [:enable, :start]
end
