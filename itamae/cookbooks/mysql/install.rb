require 'daddy/itamae'

case os_version
when /rhel-6\.(.*?)/
  package 'mysql' do
    user 'root'
  end

  package 'mysql-server' do
    user 'root'
  end

  template '/etc/my.cnf' do
    user 'root'
  end

  service 'mysqld' do
    user 'root'
    action [:enable, :start]
  end

when /rhel-7\.(.*?)/
  package 'mariadb' do
    user 'root'
  end

  package 'mariadb-server' do
    user 'root'
  end

  template '/etc/my.cnf.d/daddy.cnf' do
    user 'root'
  end

  service 'mariadb' do
    user 'root'
    action [:enable, :start]
  end

else
  raise I18n.t('itamae.errors.unsupported_os_version', :os_version => os_version)
end

execute 'mysql_secure_installation' do
  user 'root'
  command "bash #{File.join(File.dirname(__FILE__), 'mysql_secure_installation.sh')}"
  only_if "mysql -u root -e 'select 1;' && test $? -eq 0"
end
