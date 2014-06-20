require 'rake'
require 'rails'

namespace :dad do
  task :app_base_dir do
    app_base_dir = File.join('/var/lib', Daddy.config.application)
    fail unless system("sudo mkdir -p #{app_base_dir}")
    fail unless system("sudo chown root:root #{app_base_dir}")

    env_dir = File.join(app_base_dir, Rails.env)
    fail unless system("sudo mkdir -p #{env_dir}")
    fail unless system("sudo chown #{ENV['USER']}:#{ENV['USER']} #{env_dir}")
  end
end
