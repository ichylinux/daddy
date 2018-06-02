version = ENV['RUBY_VERSION'] || '2.5.1'
short_version = version.split('.')[0..1].join('.')

directory 'tmp'

execute 'download ruby' do
  cwd 'tmp'
  command <<-EOF
    rm -f ruby-#{version}.tar.gz
    wget https://cache.ruby-lang.org/pub/ruby/#{short_version}/ruby-#{version}.tar.gz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "ruby-#{version}.tar.gz_sha256sum.txt")}"
end

execute 'install ruby' do
  cwd 'tmp'
  command <<-EOF
     tar zxf ruby-#{version}.tar.gz
     pushd ruby-#{version}
       ./configure --disable-install-rdoc
       make
       sudo make install
     popd
     sudo gem update -N --system
   EOF
   not_if "ruby -v | egrep \"ruby #{version}(p[0-9]+) \""
end
