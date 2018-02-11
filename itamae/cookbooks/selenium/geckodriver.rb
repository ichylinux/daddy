require 'daddy/itamae'

directory 'tmp'

execute "download geckodriver-#{Daddy::GECKO_DRIVER_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    rm -Rf geckodriver-v#{Daddy::GECKO_DRIVER_VERSION}-linux64*
    wget https://github.com/mozilla/geckodriver/releases/download/v#{Daddy::GECKO_DRIVER_VERSION}/geckodriver-v#{Daddy::GECKO_DRIVER_VERSION}-linux64.tar.gz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "geckodriver-v#{Daddy::GECKO_DRIVER_VERSION}-linux64_sha256sum.txt")}"
end

execute "install geckodriver-#{Daddy::GECKO_DRIVER_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    tar zxf geckodriver-v#{Daddy::GECKO_DRIVER_VERSION}-linux64.tar.gz
    sudo mv -f geckodriver /usr/local/bin/
  EOF
  not_if "/usr/local/bin/geckodriver -V | grep 'geckodriver #{Daddy::GECKO_DRIVER_VERSION}'"
end
