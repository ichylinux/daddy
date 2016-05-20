require 'daddy/itamae'

%w{ zlib-devel gcc make git autoconf autogen automake pkgconfig }.each do |name|
  package name do
    user 'root'
  end
end

directory '/opt/src' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
end

git 'netdata' do
  destination '/opt/src/netdata'
  repository 'https://github.com/firehol/netdata.git'
end

execute 'netdata-installer.sh' do
  user 'root'
  cwd '/tmp/netdata'
  command "bash #{File.join(File.dirname(__FILE__), 'netdata-installer.sh')}"
end