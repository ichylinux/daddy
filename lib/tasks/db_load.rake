require_relative 'task_helper'

namespace :dad do
  namespace :db do
    desc 'データベースをロードします。'
    task :load do
      ENV['DUMP_FILE'] ||= ask('ダンプファイル', :required => true)
      run_rustic 'db', 'load'
    end
  end
end