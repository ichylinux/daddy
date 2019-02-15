require_relative 'task_helper'

namespace :dad do
  namespace :docker do

    desc 'delete stopped containers and untagged images'
    task :clean do
      unless `docker ps -qa --filter status=exited`.empty?
        run 'docker rm `docker ps -qa --filter status=exited`'
      end
      unless `docker images -q --filter "dangling=true"`.empty?
        run 'docker rmi `docker images -q --filter "dangling=true"`'
      end
    end

    namespace :registry do

      desc 'install Docker Registry'
      task :install do
        run_itamae 'docker/install', 'docker/registry/install'
      end
    end

  end
end
