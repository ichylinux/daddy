require_relative 'task_helper'

namespace :dad do

  task :app_base_dir do
    case Rails.env
    when 'production', 'development'
      app_base_dir = File.join('/var/lib', Daddy.config.application, Rails.env)
      run "sudo mkdir -p #{app_base_dir}",
          "sudo chown #{ENV['USER']}:#{ENV['USER']} #{app_base_dir}"
    when 'test'
      app_base_dir = File.join('/tmp', Daddy.config.application, Rails.env)
      run "mkdir -p #{app_base_dir}"
    end
  end

end
