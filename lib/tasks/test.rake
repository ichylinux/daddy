# coding: UTF-8

require 'rake'

namespace :dad do
  task :test => :environment do
    system("mkdir -p features/reports")
    system("bundle exec rake db:test:prepare")
    system("bundle exec rake dad:cucumber")
  end  
end
