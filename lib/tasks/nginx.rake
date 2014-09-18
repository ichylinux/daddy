require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc 'Nginxをインストールします。'
    task :install => :environment do
      repo = File.join(File.dirname(__FILE__), 'nginx', 'nginx.repo')
      fail unless system("sudo cp -f #{repo} /etc/yum.repos.d/")
      fail unless system("sudo yum install nginx")
      
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
      fail unless system("RAILS_ROOT=#{rails_root} RAILS_ENV=#{Rails.env} APP_NAME=#{app_name} erb -T - #{File.dirname(__FILE__)}/nginx.app.conf.erb > tmp/nginx.#{app_name}.conf")
      system("sudo mkdir -p /etc/nginx/conf.d/servers") 
      system("sudo cp -f tmp/nginx.#{app_name}.conf /etc/nginx/conf.d/servers/#{app_name}.conf")
    end

  end
end
