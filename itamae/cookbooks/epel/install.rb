require 'daddy/itamae'

%w{ epel-release yum-utils }.each do |name|
  package name do
    user 'root'
  end
end

execute 'yum-config-manager --enable epel' do
  user 'root'
end

execute 'yum clean all && yum update -y' do
  user 'root'
end
