require_relative 'task_helper'

namespace :dad do

  task :app_base_dir do
    ENV['APP_NAME'] ||= ask('APP_NAME', :required => true)
    run_itamae 'app_base_dir'
  end

end
