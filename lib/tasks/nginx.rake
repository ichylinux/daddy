# coding: UTF-8

require 'rake'
require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc 'Nginxをインストールします。'
    task :install => :environment do
      repo = File.dirname(__FILE__) + '/nginx.repo'
      fail unless system("sudo cp -f #{repo} /etc/yum.repos.d/")

      ret = system("sudo yum install nginx")
      fail unless ret
      
      if File.exist?('/etc/nginx/conf.d/default.conf')
        system("sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.org")
      end
      if File.exist?('/etc/nginx/conf.d/example_ssl.conf')
        system("sudo mv /etc/nginx/conf.d/example_ssl.conf /etc/nginx/conf.d/example_ssl.conf.org")
      end

      rails_root = ENV['RAILS_ROOT'] || Rails.root
      jenkins = ENV['JENKINS'] || false
      publish = ENV['PUBLISH'] || false

      fail unless system("RAILS_ROOT=#{rails_root} RAILS_ENV=#{Rails.env} erb -T - #{File.dirname(__FILE__)}/nginx.conf.erb > tmp/nginx.conf")

      system("sudo cp -f tmp/nginx.conf /etc/nginx/conf.d/nginx.conf")
      
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

    desc 'NginxにJenkinsの設定ファイルをインストールします。'
    task :jenkins => :environment do
      fail unless system("erb -T - #{File.dirname(__FILE__)}/nginx.jenkins.conf.erb > tmp/nginx.jenkins.conf")
      system("sudo mkdir -p /etc/nginx/conf.d/servers") 
      system("sudo cp -f tmp/nginx.jenkins.conf /etc/nginx/conf.d/servers/jenkins.conf")
    end

  end
end
