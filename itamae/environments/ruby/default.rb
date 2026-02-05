version = ENV['RUBY_VERSION'] || '3.4.8'
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
    sudo rm -Rf ruby-#{version}/
    tar zxf ruby-#{version}.tar.gz

    # avoid override confirmation when a different version of ruby was installed before
    sudo rm -f /usr/local/bin/{bundle,bundler,erb,irb,gem,rdoc,ruby}

    pushd ruby-#{version}
      mkdir -p build
      pushd build
        ../configure --disable-install-rdoc
        make
        sudo make install
      popd
    popd
  EOF
  not_if "ruby -v | egrep \"ruby #{version}(p[0-9]+)? \""
end

bundler_versions = case short_version
  when '2.7'
    ['2.3.26', '2.4.22']
  else
    '2.7.2'
  end
ohai_version = case short_version
  when '2.7'
    '19.0.3'
  else
    '19.1.16'
  end

{
  'bundler' => bundler_versions,
  'itamae' => '1.14.2',
  'ohai' => ohai_version
}.each do |name, versions|
  versions = Array(versions)
  versions.each do |version|
    gem_package name do
      user 'root'
      version version
      options '-N'
    end
  end
end

execute "bundle config set --global path ~/.gem/ruby/#{short_version}.0" do
  user ENV['USER']
  not_if "bundle config get path | grep -qE '\\.gem/ruby/#{short_version}.0'"
end

