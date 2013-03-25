# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :db do
    
    desc 'database.yml を生成します。'
    task :config do
      pwd = `pwd`.strip
      command = "APP_NAME=#{File.basename(pwd)} erb -T - #{File.dirname(__FILE__)}/database.yml.erb > config/database.yml"
      puts command
      system("#{command}")
    end
  end
end
