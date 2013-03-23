# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")
    
    ret = system("bundle exec rake db:schema:load RAILS_ENV=test")
    fail unless ret

    ret = system("bundle exec rake dad:cucumber #{ARGV[1..-1].join(' ')}")
    fail unless ret
  end  
end
