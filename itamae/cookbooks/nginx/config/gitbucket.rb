require 'daddy/itamae'

template '/etc/nginx/conf.d/servers/gitbucket.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  variables :server_name => ENV['SERVER_NAME'], :port => ENV['PORT']
end
