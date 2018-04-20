require 'daddy'

version = ENV['BAZEL_VERSION'] || Daddy::BAZEL_VERSION

directory 'tmp'

execute "download bazel-#{version}" do
  cwd 'tmp'
  command <<-EOF
    wget https://github.com/bazelbuild/bazel/releases/download/#{version}/bazel-#{version}-dist.zip -O bazel-#{version}-dist.zip 
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "bazel-#{version}_sha256sum.txt")}"
end

execute "install bazel-#{version}" do
  cwd 'tmp'
  command <<-EOF
    rm -Rf bazel-#{version}/
    unzip bazel-#{version}-dist.zip -d bazel-#{version}
    pushd bazel-#{version}
      bash ./compile.sh
      sudo cp -f output/bazel /usr/local/bin/
    popd
  EOF
  not_if "which bazel && bazel version | grep 'Build label: #{version}-'"
end
