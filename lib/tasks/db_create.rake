# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :db do
    
    desc 'database.yml に従ってDBを作成します。'
    task :create do
      config = YAML.load_file("#{Rails.root}/config/database.yml")
      
      system("mkdir -p tmp")
      system("echo '# mysql ddl' > tmp/create_databases.sql")
  
      config.each do |env, props|
        puts "database for environment #{env}"
        system("echo 'drop database if exists #{props['database']};' >> tmp/create_databases.sql")
        system("echo 'create database #{props['database']};' >> tmp/create_databases.sql")
        system("echo 'grant all on #{props['database']}.* to #{props['username']} identified by \"#{props['password']}\";' >> tmp/create_databases.sql")

        if ENV['FILE']
          system("echo 'grant all on #{props['database']}.* to #{props['username']}@localhost identified by \"#{props['password']}\";' >> tmp/create_databases.sql")
          system("echo 'grant file on *.* to #{props['username']}@localhost;' >> tmp/create_databases.sql")
        end
      end
      
      system("echo >> tmp/create_databases.sql")
  
      system("cat tmp/create_databases.sql")
      ret = system("mysql -u root -p < tmp/create_databases.sql")
      fail unless ret
    end
  end
end
