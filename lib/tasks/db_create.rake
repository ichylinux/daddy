require 'rake'

namespace :dad do
  namespace :db do
    
    desc 'database.yml に従ってDBを作成します。'
    task :create do
      config = YAML.load_file("#{Rails.root}/config/database.yml")
      
      FileUtils.mkdir_p("tmp")
      system("echo '# mysql ddl' > tmp/create_databases.sql")
  
      config.each do |env, props|
        next if env == 'default'

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

      puts
      puts File.read('tmp/create_databases.sql')

      if ENV['DAD_MYSQL_NO_ROOT_PASSWORD']
        fail unless system("mysql -u root < tmp/create_databases.sql")
      else
        fail unless system("mysql -u root -p < tmp/create_databases.sql")
      end
    end
  end
end
