# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")
    
    args = ARGV[1..-1].join(' ')
    command = "bundle exec rake dad:cucumber #{args}"
    #puts command
    ret = system(command)
    fail unless ret
  end  
end
