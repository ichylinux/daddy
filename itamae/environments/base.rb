%w{
  ImageMagick-devel
  autoconf
  automake
  epel-release
  gcc
  gcc-c++
  graphviz
  libcurl-devel
  libffi-devel
  libtool
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
