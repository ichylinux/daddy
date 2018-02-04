directory 'tmp'

execute "download chromedriver-#{Daddy::CHROME_DRIVER_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    curl -o chromedriver_linux64-#{Daddy::CHROME_DRIVER_VERSION}.zip \
        https://chromedriver.storage.googleapis.com/#{Daddy::CHROME_DRIVER_VERSION}/chromedriver_linux64.zip
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "chromedriver_linux64-#{Daddy::CHROME_DRIVER_VERSION}_sha256sum.txt")}"
end

execute "install chromedriver-#{Daddy::CHROME_DRIVER_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    unzip chromedriver_linux64-#{Daddy::CHROME_DRIVER_VERSION}.zip
    sudo mv chromedriver /usr/local/bin/
  EOF
  not_if "/usr/local/bin/chromedriver -v | grep 'ChromeDriver 2.35'"
end
