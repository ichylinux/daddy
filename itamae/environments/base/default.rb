%w{
  autoconf
  automake
  gcc
  gcc-c++
  git
  glibc-langpack-ja
  make
  libcurl-devel
  libffi-devel
  libtool
  libxml2-devel
  libxslt-devel
  openssl-devel
  patch
  readline-devel
  shared-mime-info
  sudo
  tar
  unzip
  wget
  which
  zip
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
    only_if "grep -qE '^AlmaLinux release 8\.[0-9]+' /etc/almalinux-release"
  end
end

%w{
  libyaml-devel
}.each do |name|
  package name do
    user 'root'
    options '--enablerepo=crb'
    only_if "grep -qE '^AlmaLinux release 9\.[0-9]+' /etc/almalinux-release"
  end
end
