require_relative 'task_helper'

namespace :dad do
  namespace :mysql do

    desc 'MySQLをインストールします。'
    task :install do
      run_itamae 'mysql/install'
    end

  end
end
