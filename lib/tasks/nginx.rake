require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc 'Nginxをインストールします。'
    task :install => :environment do
      repo = File.join(File.dirname(__FILE__), 'nginx', 'nginx.repo')
      run "sudo cp -f #{repo} /etc/yum.repos.d/",
          "sudo yum install nginx"
      
      default_config_files = [
        '/etc/nginx/conf.d/default.conf',
        '/etc/nginx/conf.d/example_ssl.conf'
      ]
      default_config_files.each do |conf|
        run "sudo mv #{conf} #{conf}.org" if File.exist?(conf)
      end

      template = File.join(File.dirname(__FILE__), 'nginx', 'nginx.conf.erb')
      render template, :to => 'tmp/nginx.conf'
      run "sudo cp -f tmp/nginx.conf /etc/nginx/conf.d/nginx.conf"
      run "sudo mkdir -p /etc/nginx/conf.d/servers"

      publish = ENV['PUBLISH'] || false
      if publish
        system("sudo mkdir -p /var/lib/daddy")
        system("sudo chown -R #{ENV['USER']}:#{ENV['USER']} /var/lib/daddy")
      end
    end

    desc 'Nginxにアプリケーションの設定ファイルをインストールします。'
    task :config => :environment do
      conf = File.join('tmp', 'nginx', "#{app_name}.conf")
      render File.join(File.dirname(__FILE__), 'nginx', 'app.conf.erb'), :to => conf

      unless dry_run?
        run "sudo mkdir -p /etc/nginx/conf.d/servers",
            "sudo cp -f #{conf} /etc/nginx/conf.d/servers/"
      end
    end

  end
end
