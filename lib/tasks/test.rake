require_relative 'task_helper'

namespace :dad do
  
  desc 'Cucumberを使用してテストを実行します。'
  task :test => :environment do
    require 'closer/tasks'
    Rake::Task['close'].invoke
  end

end
