require 'daddy/itamae'

%w{ mod_ssl vsftpd }.each do |name|
  package name do
    user 'root'
  end
end

template '/etc/vsftpd/vsftpd.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '600'
end

service 'vsftpd' do
  user 'root'
  action [:enable, :start]
end

service 'vsftpd' do
  user 'root'
  subscribes :restart, "template[/etc/vsftpd/vsftpd.conf]"
  action :nothing
end
