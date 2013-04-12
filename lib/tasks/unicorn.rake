# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :unicorn do

    desc 'Unicornをインストールします。'
    task :install => :environment do
      rails_env = ENV['RAILS_ENV'] || Rails.env
      rails_root = ENV['RAILS_ROOT'] || Rails.root
      ret = system("RAILS_ENV=#{rails_env} RAILS_ROOT=#{rails_root} erb -T - #{File.dirname(__FILE__)}/unicorn.erb > tmp/unicorn")
      fail unless ret

      system("sudo cp -f #{File.dirname(__FILE__)}/unicorn.rb config/unicorn.rb")

      system("sudo cp -f tmp/unicorn /etc/init.d/unicorn")
      system("sudo chown root:root /etc/init.d/unicorn")
      system("sudo chmod 755 /etc/init.d/unicorn")
      system("sudo /sbin/chkconfig unicorn on")
    end  

  end
end
