%w{
  autoconf
  automake
  curl
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

case node[:platform]
when 'almalinux'
  %w{
    libyaml-devel
  }.each do |name|
    package name do
      user 'root'
      options '--enablerepo=powertools'
    end
  end

  execute 'dnf clean all --enablerepo=powertools' do
    user 'root'
  end
when 'amazon'
  %w{
    libyaml-devel
  }.each do |name|
    package name do
      user 'root'
    end
  end

  execute 'yum clean all' do
    user 'root'
  end
end
