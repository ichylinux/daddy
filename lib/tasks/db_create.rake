require_relative 'task_helper'

namespace :dad do
  namespace :db do
    desc 'database.yml に従ってDBを作成します。'
    task :create do
      run_rustic 'db', 'create'
    end
  end
end