case os_version
when /rhel-6\.(.*?)/
  package 'mysql' do
    user 'root'
  end

  package 'mysql-server' do
    user 'root'
  end

  service 'mysqld' do
    action [:enable, :start]
  end

when /rhel-7\.(.*?)/
  package 'mariadb' do
    user 'root'
  end

  package 'mariadb-server' do
    user 'root'
  end

  service 'mariadb' do
    action [:enable, :start]
  end

else
  raise "サポートしていないOSバージョンです。#{os_version}"
end

