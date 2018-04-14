require 'daddy'

directory 'tmp'

version = ENV['CHROME_DRIVER_VERSION'] || Daddy::CHROME_DRIVER_VERSION

execute "download chromedriver-#{version}" do
  cwd 'tmp'
  command <<-EOF
    curl -o chromedriver_linux64-#{version}.zip \
        https://chromedriver.storage.googleapis.com/#{version}/chromedriver_linux64.zip
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "chromedriver_linux64-#{version}_sha256sum.txt")}"
end

execute "install chromedriver-#{version}" do
  cwd 'tmp'
  command <<-EOF
    unzip chromedriver_linux64-#{version}.zip
    sudo mv -f chromedriver /usr/local/bin/
  EOF
  not_if "/usr/local/bin/chromedriver -v | grep 'ChromeDriver #{version}'"
end
