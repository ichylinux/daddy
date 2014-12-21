require 'rake'

namespace :dad do
  namespace :phantomjs do

    desc "PhantomJSをインストールします。"
    task :install do
      name = 'phantomjs-1.9.8-linux-x86_64'
      file = "#{name}.tar.bz2"

      run "wget https://bitbucket.org/ariya/phantomjs/downloads/#{file} -O tmp/#{file}" unless File.exist?("tmp/#{file}")
      run "rm -Rf tmp/#{name}",
          "cd tmp && tar jxf #{file}"

      run "sudo cp -f tmp/#{name}/bin/phantomjs /usr/local/bin/phantomjs",
          "sudo chown root:root /usr/local/bin/phantomjs",
          "sudo chmod 755 /usr/local/bin/phantomjs"
    end

  end
end
