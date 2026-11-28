%w{
  autoconf
  automake
  curl
  git
  make
  libtool
  patch
  shared-mime-info
  sudo
  tar
  unzip
  wget
  zip
}.each do |name|
  package name do
    user 'root'
  end
end

%w{
  gcc
  gcc-c++
  glibc-langpack-ja
  libcurl-devel
  libffi-devel
  libxml2-devel
  libxslt-devel
  openssl-devel
  readline-devel
  which
  zlib-devel
}.each do |name|
  package name do
    user 'root'
    only_if 'test -f /etc/redhat-release'
  end
end

%w{
  gcc
  g++
  language-pack-ja-base
  libcurl4-openssl-dev
  libffi-dev
  libxml2-dev
  libxslt1-dev
  libssl-dev
  libreadline-dev
  zlib1g-dev
  libyaml-dev
}.each do |name|
  package name do
    user 'root'
    only_if 'test -f /etc/debian_version'
  end
end

%w{
  libyaml-devel
}.each do |name|
  package name do
    user 'root'
    options '--enablerepo=powertools'
    only_if "grep -qE '^AlmaLinux release 8\\.[0-9]+' /etc/almalinux-release"
  end
end

%w{
  libyaml-devel
}.each do |name|
  package name do
    user 'root'
    options '--enablerepo=crb'
    only_if "grep -qE '^AlmaLinux release 9\\.[0-9]+' /etc/almalinux-release"
  end
end