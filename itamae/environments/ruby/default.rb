version = ENV['RUBY_VERSION'] || '2.7.6'
short_version = version.split('.')[0..1].join('.')

execute "download ruby-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    set -eu
    rm -f ruby-#{version}.tar.gz
    wget https://cache.ruby-lang.org/pub/ruby/#{short_version}/ruby-#{version}.tar.gz
  EOF
  not_if "echo #{::File.read(::File.join(::File.dirname(__FILE__), "ruby-#{version}.tar.gz_sha256sum.txt")).strip} | sha256sum -c"
end

execute "install ruby-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    set -eu
    tar zxf ruby-#{version}.tar.gz
    pushd ruby-#{version}
      ./configure --disable-install-rdoc
      make
      sudo make install
    popd
  EOF
  not_if "ruby -v | egrep \"ruby #{version}(p[0-9]+) \""
end

{
  'rubygems-update' => nil,
  'bundler' => '2.3.4',
  'itamae' => '1.12.5',
  'daddy' => nil
}.each do |name, version|
  gem_package name do
    user 'root'
    version version if version
  end
end
