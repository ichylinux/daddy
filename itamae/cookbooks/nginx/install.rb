require 'daddy/itamae'

dad_nginx_checksum = File.join(File.dirname(__FILE__), 'sha256sum.txt')

directory 'tmp'

# nginx source
execute 'download nginx' do
  cwd 'tmp'
  command <<-EOF
    wget https://nginx.org/download/nginx-1.11.10.tar.gz
  EOF
  not_if "sha256sum -c #{dad_nginx_checksum}"
end

# nginx-rtmp-module source
directory '/opt/nginx-rtmp-module' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end
git '/opt/nginx-rtmp-module/v1.1.11' do
  repository 'https://github.com/arut/nginx-rtmp-module.git'
  revision 'v1.1.11'
end

# build
execute 'build nginx' do
  cwd 'tmp'
  command <<-EOF
    rm -Rf nginx-1.11.10
    tar zxf nginx-1.11.10.tar.gz
    cd nginx-1.11.10
    ./configure \
      --prefix=/opt/nginx-1.11.10 \
      --conf-path=/etc/nginx/nginx.conf \
      --pid-path=/run/nginx.pid \
      --with-http_ssl_module \
      --add-module=/opt/nginx-rtmp-module/v1.1.11
    make
    sudo make install
    sudo ln -snf /opt/nginx-1.11.10 /opt/nginx
  EOF
  not_if "test -e /opt/nginx"
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
