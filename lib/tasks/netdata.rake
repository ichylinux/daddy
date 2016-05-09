require_relative 'task_helper'

namespace :dad do
  namespace :netdata do

    desc 'netdataをインストールします。'
    task :install do
      run_itamae 'netdata/install'
    end

  end
end
