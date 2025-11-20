version = ENV['RUBY_VERSION'] || '3.4.7'
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
    rm -Rf ruby-#{version}/
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

{
  'bundler' => ['2.7.2'],
  'itamae' => '1.14.1',
  'ohai' => '19.0.3'
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

execute 'gem update --system 3.7.2 -N' do
  user 'root'
  action :nothing
  subscribes :run, "gem_package[bundler]", :immediately
end

execute "bundle config set --global path ~/.gem/ruby/#{short_version}.0" do
  user ENV['USER']
  not_if "bundle config get path | grep -qE '\\.gem/ruby/#{short_version}.0'"
end

