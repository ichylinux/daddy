execute 'yum -y groupinstall "Development Tools"' do
  user 'root'
end

%w{
  ImageMagick-devel
  libcurl-devel
  libffi-devel
  libxml2-devel
  libxslt-devel
  libyaml-devel
  mariadb-devel
  openssl-devel
  readline-devel
  sqlite-devel
  zlib-devel
}.each do |name|
  package name do
    user 'root'
  end
end
