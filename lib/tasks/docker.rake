require_relative 'task_helper'

namespace :dad do
  namespace :docker do

    desc 'Dockerをインストールします。'
    task :install do
      run_itamae 'docker/install'
    end

  end
end
