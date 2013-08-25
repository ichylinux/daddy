# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :unicorn do

    desc 'Unicornをインストールします。'
    task :install => :environment do
      rails_env = ENV['RAILS_ENV'] || Rails.env
      rails_root = ENV['RAILS_ROOT'] || Rails.root
      init_script = 'unicorn_' + YAML.load_file("config/database.yml")[Rails.env]['database']

      commands = [
        "RAILS_ENV=#{rails_env} RAILS_ROOT=#{rails_root} erb -T - #{File.dirname(__FILE__)}/unicorn.erb > tmp/#{init_script}",
        "RAILS_ENV=#{rails_env} RAILS_ROOT=#{rails_root} erb -T - #{File.dirname(__FILE__)}/unicorn.rb.erb > config/unicorn.rb",

        "sudo cp -f tmp/#{init_script} /etc/init.d/#{init_script}",
        "sudo chown root:root /etc/init.d/#{init_script}",
        "sudo chmod 755 /etc/init.d/#{init_script}",
        "sudo /sbin/chkconfig #{init_script} on",
      ]

      commands.each do |c|
        puts c
        fail unless system(c)
      end
    end  

  end
end
