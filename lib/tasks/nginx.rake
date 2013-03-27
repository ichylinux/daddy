# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :nginx do

    desc 'Nginxをインストールします。'
    task :install do
      repo = File.dirname(__FILE__) + '/nginx.repo'
      ret = system("sudo cp -f #{repo} /etc/yum.repos.d/")
      fail unless ret

      ret = system("sudo yum install nginx")
      fail unless ret
      
      if File.exist?('/etc/nginx/conf.d/default.conf')
        system("sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.org")
      end
      if File.exist?('/etc/nginx/conf.d/example_ssl.conf')
        system("sudo mv /etc/nginx/conf.d/example_ssl.conf /etc/nginx/conf.d/example_ssl.conf.org")
      end

      rails_root = ENV['RAILS_ROOT'] || Rails.root
      ret = system("RAILS_ROOT=#{rails_root} erb -T - #{File.dirname(__FILE__)}/nginx.conf.erb > tmp/nginx.conf")
      fail unless ret
      system("sudo cp -f tmp/nginx.conf /etc/nginx/conf.d/nginx.conf")
    end  

  end
end
