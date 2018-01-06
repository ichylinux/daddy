directory 'tmp'

execute "download python-#{Daddy::PYTHON_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    curl -O https://www.python.org/ftp/python/#{Daddy::PYTHON_VERSION}/Python-#{Daddy::PYTHON_VERSION}.tar.xz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "Python-#{Daddy::PYTHON_VERSION}_sha256sum.txt")}"
end

execute "install python-#{Daddy::PYTHON_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    rm -Rf Python-#{Daddy::PYTHON_VERSION}/
    tar Jxf Python-#{Daddy::PYTHON_VERSION}.tar.xz
    pushd Python-#{Daddy::PYTHON_VERSION}
      ./configure --enable-optimizations
      make
      sudo make install
    popd
  EOF
  not_if "which python3 && python3 -V | grep 'Python #{Daddy::PYTHON_VERSION}'" 
end
