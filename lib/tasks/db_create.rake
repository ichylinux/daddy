require 'rake'

namespace :dad do
  namespace :db do
    
    desc 'database.yml に従ってDBを作成します。'
    task :create do
      config = YAML.safe_load(ERB.new(File.read('config/database.yml'), trim_mode: '-').result, aliases: true)
      
      FileUtils.mkdir_p("tmp")
      system("echo '# mysql ddl' > tmp/create_databases.sql")
  
      user = host = port = nil
      config.each do |env, props|
        next if env == 'default'
        next if props['username'] == user

        user = props['username']
        host = props['host']
        port = props['port']
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

      options = []
      if host
        port ||= 3306 if host != 'localhost'
        options << "-h #{host}"
        options << "-P #{port}" if port
      end
      options << "-u #{ENV['MYSQL_ROOT'] || 'root'}"
      unless ENV['MYSQL_ALLOW_EMPTY_PASSWORD']
        options << '-p'
      end

      command = "mysql #{options.join(' ')} < tmp/create_databases.sql"
      puts command
      fail unless system(command)
    end
  end
end
