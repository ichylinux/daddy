# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    system("mkdir -p features/reports")
    system("bundle exec rake db:test:prepare")
    system("bundle exec rake dad:cucumber #{ARGV[1..-1].join(' ')}")
  end  
end
