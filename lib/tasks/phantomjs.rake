# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :phantomjs do

    desc "PhantomJSをインストールします。"
    task :install do
      name = 'phantomjs-1.9.7-linux-x86_64'
      file = "#{name}.tar.bz2"
      unless File.exist?("tmp/#{file}")
        system("wget https://bitbucket.org/ariya/phantomjs/downloads/#{file} -O tmp/#{file}")
      end
      system("rm -Rf tmp/#{name}")
      system("cd tmp && tar jxf #{file}")

      system("sudo cp -f tmp/#{name}/bin/phantomjs /usr/local/bin/phantomjs")
      system("sudo chown root:root /usr/local/bin/phantomjs")
      system("sudo chmod 755 /usr/local/bin/phantomjs")
    end

  end
end
