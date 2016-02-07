require 'daddy/itamae'

ENV['DAD_PHANTOMJS_VERSION'] ||= '2.1.1'
ENV['DAD_PHANTOMJS_PACKAGE'] ||= "phantomjs-#{ENV['DAD_PHANTOMJS_VERSION']}-linux-x86_64"

package 'fontconfig'

directory 'tmp'
directory 'tmp/daddy'

execute 'PhantomJSのダウンロード' do
  cwd 'tmp/daddy'
  command "wget https://bitbucket.org/ariya/phantomjs/downloads/#{ENV['DAD_PHANTOMJS_PACKAGE']}.tar.bz2"
  not_if "test `/usr/local/bin/phantomjs -v` = #{ENV['DAD_PHANTOMJS_VERSION']}"
end

execute 'PhantomJSのインストール' do
  cwd 'tmp/daddy'
  command <<-EOF
    rm -Rf #{ENV['DAD_PHANTOMJS_PACKAGE']}
    tar jxf #{ENV['DAD_PHANTOMJS_PACKAGE']}.tar.bz2
    sudo cp -f #{ENV['DAD_PHANTOMJS_PACKAGE']}/bin/phantomjs /usr/local/bin/phantomjs
    sudo chown root:root /usr/local/bin/phantomjs
    sudo chmod 755 /usr/local/bin/phantomjs
  EOF
  not_if "test `/usr/local/bin/phantomjs -v` = #{ENV['DAD_PHANTOMJS_VERSION']}"
end
