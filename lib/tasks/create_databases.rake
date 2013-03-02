# coding: UTF-8

require 'rake'

namespace :dad do
  task :create_databases do
    config = YAML.load_file("#{Rails.root}/config/database.yml")
    
    system("mkdir -p tmp")
    system("echo '# mysql ddl' > tmp/create_databases.sql")

    config.each do |env, props|
      puts "database for environment #{env}"
      system("echo 'drop database if exists #{props['database']};' >> tmp/create_databases.sql")
      system("echo 'create database #{props['database']};' >> tmp/create_databases.sql")
      system("echo 'grant all on #{props['database']}.* to #{props['username']} identified by \"#{props['password']}\";' >> tmp/create_databases.sql")
    end
    
    system("echo >> tmp/create_databases.sql")

    system("cat tmp/create_databases.sql")
    ret = system("mysql -u root -p < tmp/create_databases.sql")
    fail unless ret
  end
end
