%w{
  autoconf
  automake
  curl
  gcc
  gcc-c++
  git
  make
  libcurl-devel
  libffi-devel
  libtool
  libxml2-devel
  libxslt-devel
  openssl-devel
  readline-devel
  sudo
  wget
  which
  zlib-devel
}.each do |name|
  package name do
    user 'root'
  end
end

%w{
  libyaml-devel
}.each do |name|
  package name do
    user 'root'
    options '--enablerepo=powertools'
  end
end
