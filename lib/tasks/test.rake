# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")

    args = []    
    ARGV[1..-1].each do |arg|
      unless arg.index('=')
        task arg.to_sym do ; end
      end
      args << arg
    end

    command = "bundle exec rake dad:cucumber #{args.join(' ')}"
    puts command
    fail unless system(command)
  end  
end
