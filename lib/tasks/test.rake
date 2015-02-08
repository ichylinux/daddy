require_relative 'task_helper'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    run 'mkdir -p features/reports',
        'rm -Rf features/reports/*'

    ENV['FORMAT'] ||= 'Daddy::Formatter::Html'
    Rake::Task['close'].invoke
  end

end
