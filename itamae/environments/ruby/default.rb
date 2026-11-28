version = ENV['RUBY_VERSION'] || '3.4.13'
short_version = version.split('.')[0..1].join('.')
work_dir = '/var/daddy/tmp'
tarball = "ruby-#{version}.tar.gz"
sha256 = ::File.read(::File.join(::File.dirname(__FILE__), "#{tarball}_sha256sum.txt")).strip

# NOTE: mitamae silently ignores `cwd` when the directory does not exist and
# then runs in the process cwd (the repository root). Keep the `cd` inside the
# command so a missing work dir fails loudly instead of polluting the repo.
execute "download ruby-#{version}" do
  command <<-EOF
    set -eu
    cd #{work_dir}
    rm -f #{tarball}
    wget https://cache.ruby-lang.org/pub/ruby/#{short_version}/#{tarball}
  EOF
  not_if "cd #{work_dir} && echo #{sha256} | sha256sum -c"
end

execute "install ruby-#{version}" do
  command <<-EOF
    set -eu
    cd #{work_dir}
    sudo rm -Rf ruby-#{version}/
    tar zxf #{tarball}

    # avoid override confirmation when a different version of ruby was installed before
    sudo rm -f /usr/local/bin/{bundle,bundler,erb,irb,gem,rdoc,ruby}

    cd ruby-#{version}
    mkdir -p build
    (cd build && ../configure --disable-install-rdoc && make && sudo make install)
  EOF
  not_if "ruby -v | egrep \"ruby #{version}(p[0-9]+)? \""
end

bundler_versions = case short_version
  when '2.7'
    ['2.3.26', '2.4.22']
  else
    ['4.0.18']
  end
ohai_version = case short_version
  when '2.7'
    '19.0.3'
  else
    '19.1.24'
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

