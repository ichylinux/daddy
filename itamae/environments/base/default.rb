%w{
  ImageMagick-devel
  autoconf
  automake
  epel-release
  gcc
  gcc-c++
  git
  graphviz
  make
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
  sudo
  wget
  which
  zlib-devel
}.each do |name|
  package name do
    user 'root'
  end
end
