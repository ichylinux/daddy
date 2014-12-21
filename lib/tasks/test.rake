require_relative 'task_helper'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    run 'mkdir -p features/reports',
        'rm -Rf features/reports/*'

    args = []    
    ARGV[1..-1].each do |arg|
      unless arg.index('=')
        task arg.to_sym do ; end
      end
      args << arg
    end

    format = ENV['FORMAT'] || 'Daddy::Formatter::Html'
    coverage = ENV['COVERAGE'] || true
    run "bundle exec rake close FORMAT=#{format} COVERAGE=#{coverage} #{args.join(' ')}"
  end  
end
