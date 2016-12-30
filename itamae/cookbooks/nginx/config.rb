require 'daddy/itamae'

directory '/etc/nginx/conf.d/servers' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

template "/etc/nginx/conf.d/servers/#{ENV['APP_NAME']}.conf" do
  source 'templates/app.conf.erb'
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  variables :app_name => ENV['APP_NAME'],
      :server_name => ENV['SERVER_NAME'],
      :rails_env => ENV['RAILS_ENV'],
      :rails_root => ENV['RAILS_ROOT'],
      :behind_load_balancer => false
end
