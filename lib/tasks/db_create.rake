require 'rake'

namespace :dad do
  namespace :db do
    
    desc 'database.yml に従ってDBを作成します。'
    task :create do
      config = YAML.safe_load(ERB.new(File.read('config/database.yml'), 0, '-').result, [], [], aliases: true)
      
      FileUtils.mkdir_p("tmp")
      system("echo '# mysql ddl' > tmp/create_databases.sql")
  
      user = nil
      config.each do |env, props|
        next if env == 'default'
        next if props['username'] == user

        user = props['username']
        system("echo 'drop user if exists \"#{user}\"@\"%\";' >> tmp/create_databases.sql")
        system("echo 'create user \"#{user}\"@\"%\" IDENTIFIED BY \"#{props['password']}\";' >> tmp/create_databases.sql")
      end

      config.each do |env, props|
        next if env == 'default'
        next if ENV['RAILS_ENV'] and ENV['RAILS_ENV'] != env

        system("echo 'drop database if exists #{props['database']};' >> tmp/create_databases.sql")
        system("echo 'create database #{props['database']};' >> tmp/create_databases.sql")
        system("echo 'grant all on #{props['database']}.* to #{user};' >> tmp/create_databases.sql")

        if ENV['FILE']
          system("echo 'grant all on #{props['database']}.* to #{user}@localhost;' >> tmp/create_databases.sql")
          system("echo 'grant file on *.* to #{user}@localhost;' >> tmp/create_databases.sql")
        end
        puts "database for environment #{env} written to tmp/create_databases.sql"
      end

      system("echo 'flush privileges;' >> tmp/create_databases.sql")
      system("echo >> tmp/create_databases.sql")

      if ENV['MYSQL_NO_ROOT_PASSWORD']
        fail unless system("mysql -u root < tmp/create_databases.sql")
      else
        fail unless system("mysql -u #{ENV['MYSQL_ROOT'] || 'root'} -p < tmp/create_databases.sql")
      end
    end
  end
end
