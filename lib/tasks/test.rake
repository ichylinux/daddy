# coding: UTF-8

require 'rake'

Rake::Task["test"].clear

task :test => :environment do
  system("mkdir -p features/reports")
  system("bundle exec rake db:schema:load RAILS_ENV=test")
  system("bundle exec rake dad:cucumber")
end