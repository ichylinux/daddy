require_relative 'task_helper'

namespace :dad do

  task :app_base_dir do
    app_base_dir = File.join('/var/lib', Daddy.config.application)
    run "sudo mkdir -p #{app_base_dir}",
        "sudo chown #{ENV['USER']}:#{ENV['USER']} #{app_base_dir}"
  end

end
