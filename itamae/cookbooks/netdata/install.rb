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

execute 'mysql_secure_installation' do
  user 'root'
  command "bash #{File.join(File.dirname(__FILE__), 'mysql_secure_installation.sh')}"
  only_if "mysql -u root -e 'select 1;' && test $? -eq 0"
end

execute 'netdata-installer.sh' do
  user 'root'
  cwd '/tmp/netdata'
  command "bash #{File.join(File.dirname(__FILE__), 'netdata-installer.sh')}"
end