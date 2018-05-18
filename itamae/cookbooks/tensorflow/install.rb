require 'daddy/itamae'

directory '/opt/tensorflow' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end

include_recipe '../python/install'
include_recipe '../bazel/install'

{
  dev: '0.4.0',
  numpy: '1.13.3',
  pip: '9.0.1',
  wheel: '0.30.0'
}.each do |name, ver|
  pip name.to_s do
    user 'root'
    pip_binary 'pip3'
    version ver
  end
end

git '/opt/tensorflow/v1.8.0' do
  repository 'https://github.com/tensorflow/tensorflow'
  revision 'v1.8.0'
end

local_ruby_block 'install tensorflow' do
  cwd '/opt/tensorflow/v1.8.0'
  block do
    Itamae.logger.info ''
    Itamae.logger.info 'Run following commands to proceed.'
    Itamae.logger.info "\n\n" + <<-EOF
PYTHON_BIN_PATH=/usr/local/bin/python3 ./configure
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package 
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
sudo pip3 install /tmp/tensorflow_pkg/tensorflow-1.8.0-cp36-cp36m-linux_x86_64.whl
    EOF
  end
end
