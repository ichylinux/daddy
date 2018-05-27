require 'daddy/itamae'

version = ENV['NGINX_VERSION']

directory 'tmp'

# install destination
%w{
  /opt/nginx
  /opt/nginx/cache
  /opt/nginx/shared
  /opt/nginx/shared/logs
}.each do |name|
  directory name do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
end

# nginx source
execute 'download nginx' do
  cwd 'tmp'
  command <<-EOF
    wget https://nginx.org/download/nginx-#{version}.tar.gz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "nginx-#{version}_sha256sum.txt")}"
end

# module sources
include_recipe 'modules/nginx-rtmp-module'
include_recipe 'modules/passenger'

# build
execute 'build nginx' do
  cwd 'tmp'
  command <<-EOF
    rm -Rf nginx-#{version}/
    tar zxf nginx-#{version}.tar.gz
    pushd nginx-#{version}
      sudo ./configure \
        --prefix=/opt/nginx/nginx-#{version} \
        --conf-path=/etc/nginx/nginx.conf \
        --pid-path=/run/nginx.pid \
        --with-http_ssl_module \
        --add-dynamic-module=/opt/nginx-rtmp-module/v1.1.11 \
        --add-dynamic-module=$(passenger-config --nginx-addon-dir)
      sudo chown -R #{ENV['USER']}:#{ENV['USER']} ./
      make
      sudo make install
    popd
  EOF
  not_if "test -e /opt/nginx/nginx-#{version}"
end

link 'current' do
  user 'root'
  cwd '/opt/nginx'
  to "nginx-#{version}"
  force true
end

template '/etc/nginx/nginx.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

%w{
  /etc/nginx/conf.d
  /var/run/passenger-instreg
}.each do |name|
  directory name do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
end

case os_version
when /rhel-6\.(.*?)/
when /rhel-7\.(.*?)/
  template '/etc/tmpfiles.d/passenger.conf' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
    variables :path => '/var/run/passenger-instreg',
        :owner => 'root', :group => 'root', :mode => '0755'
    end
end

template '/etc/nginx/conf.d/default.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
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
