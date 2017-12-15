directory 'tmp'

execute "download bazel-#{Daddy::BAZEL_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    wget https://github.com/bazelbuild/bazel/releases/download/#{Daddy::BAZEL_VERSION}/bazel-#{Daddy::BAZEL_VERSION}-dist.zip -O bazel-#{Daddy::BAZEL_VERSION}-dist.zip 
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "bazel-#{Daddy::BAZEL_VERSION}_sha256sum.txt")}"
end

execute "install bazel-#{Daddy::BAZEL_VERSION}" do
  cwd 'tmp'
  command <<-EOF
    rm -Rf bazel-#{Daddy::BAZEL_VERSION}/
    unzip bazel-#{Daddy::BAZEL_VERSION}-dist.zip -d bazel-#{Daddy::BAZEL_VERSION}
    pushd bazel-#{Daddy::BAZEL_VERSION}
      bash ./compile.sh
      sudo cp -f output/bazel /usr/local/bin/
    popd
  EOF
  not_if "which bazel && bazel version | grep 'Build label: #{Daddy::BAZEL_VERSION}-'"
end
