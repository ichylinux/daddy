require 'daddy/itamae'

dad_nginx_checksum = File.join(File.dirname(__FILE__), 'sha256sum.txt')
dad_nginx_version = '1.12.0'

directory 'tmp'

# nginx source
execute 'download nginx' do
  cwd 'tmp'
  command <<-EOF
    wget https://nginx.org/download/nginx-#{dad_nginx_version}.tar.gz
  EOF
  not_if "sha256sum -c #{dad_nginx_checksum}"
end

# module sources
include_recipe 'modules/nginx-rtmp-module'
include_recipe 'modules/passenger'

# build
execute 'build nginx' do
  cwd 'tmp'
  command <<-EOF
    rm -Rf nginx-#{dad_nginx_version}
    tar zxf nginx-#{dad_nginx_version}.tar.gz
    cd nginx-#{dad_nginx_version}
    sudo ./configure \
      --prefix=/opt/nginx-#{dad_nginx_version} \
      --conf-path=/etc/nginx/nginx.conf \
      --pid-path=/run/nginx.pid \
      --with-http_ssl_module \
      --add-dynamic-module=/opt/nginx-rtmp-module/v1.1.11 \
      --add-dynamic-module=$(passenger-config --nginx-addon-dir)
    sudo chown -R #{ENV['USER']}:#{ENV['USER']} ./
    make
    sudo make install
  EOF
  not_if "test -e /opt/nginx-#{dad_nginx_version}"
end

link 'nginx' do
  user 'root'
  cwd '/opt'
  to "nginx-#{dad_nginx_version}"
  force true
end

template '/etc/nginx/nginx.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

directory '/etc/nginx/conf.d' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

template '/etc/nginx/conf.d/default.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  variables :passenger_root => `sudo passenger-config about root`
end

directory '/etc/nginx/conf.d/servers' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

template '/lib/systemd/system/nginx.service' do
  user 'root'
end

execute 'systemctl daemon-reload' do
  user 'root'
  subscribes :run, 'template[/lib/systemd/system/nginx.service]'
  action :nothing
end

service 'nginx' do
  user 'root'
  action :enable
end
