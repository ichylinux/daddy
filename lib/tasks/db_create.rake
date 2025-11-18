require_relative 'task_helper'

namespace :dad do
  namespace :db do
    include DatabaseHelpers

    desc 'database.yml に従ってDBを作成します。'
    task :create do
      config = YAML.safe_load(ERB.new(File.read('config/database.yml'), trim_mode: '-').result, aliases: true)
      
      FileUtils.mkdir_p("tmp")
      system("echo '# mysql ddl' > tmp/create_databases.sql")
  
      # Collect all unique users from the target environment and databases
      users = {}
      host = port = nil

      config.each do |env, props|
        next if env == 'default'
        next if ENV['RAILS_ENV'] and ENV['RAILS_ENV'] != env
        
        if multiple_databases?(props)
          # Multiple databases configuration (Rails 8 style)
          props.each do |db_name, db_config|
            next unless db_config.is_a?(Hash) && db_config['username']
            username = db_config['username']
            users[username] ||= {
              'password' => db_config['password'],
              'host' => db_config['host'],
              'port' => db_config['port']
            }
            host ||= db_config['host']
            port ||= db_config['port']
          end
        else
          # Single database configuration
          next unless props['username']
          username = props['username']
          users[username] ||= {
            'password' => props['password'],
            'host' => props['host'],
            'port' => props['port']
          }
          host ||= props['host']
          port ||= props['port']
        end
      end
      
      # Create users
      users.each do |username, user_info|
        system("echo 'drop user if exists \"#{username}\"@\"%\";' >> tmp/create_databases.sql")
        system("echo 'create user \"#{username}\"@\"%\" IDENTIFIED BY \"#{user_info['password']}\";' >> tmp/create_databases.sql")
      end

      # Create databases
      config.each do |env, props|
        next if env == 'default'
        next if ENV['RAILS_ENV'] and ENV['RAILS_ENV'] != env

        if multiple_databases?(props)
          # Multiple databases configuration (Rails 8 style)
          props.each do |db_name, db_config|
            next unless db_config.is_a?(Hash) && db_config['database']
            database = db_config['database']
            username = db_config['username']
            
            create_database_sql(database, username)
            puts "database #{database} (#{env}/#{db_name}) written to tmp/create_databases.sql"
          end
        else
          # Single database configuration
          next unless props['database']
          database = props['database']
          username = props['username']
          
          create_database_sql(database, username)
          puts "database #{database} (#{env}) written to tmp/create_databases.sql"
        end
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
