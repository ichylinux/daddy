gem_package 'passenger' do
  user 'root'
  version Daddy::PASSENGER_VERSION
end

execute "rm -Rf /opt/nginx/nginx-#{Daddy::NGINX_VERSION}" do
  user 'root'
  subscribes :run, 'gem_package[passenger]'
  action :nothing
end
