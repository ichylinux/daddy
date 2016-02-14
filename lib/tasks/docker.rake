require_relative 'task_helper'

namespace :dad do
  namespace :docker do

    desc 'install Docker'
    task :install do
      run_itamae 'docker/install'
    end

    namespace :registry do

      desc 'install Docker Registry'
      task :install do
        run_itamae 'docker/registry/install'
      end
    end

  end
end
