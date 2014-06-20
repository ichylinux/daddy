require 'rake'
require 'rails'

namespace :dad do
  task :app_base_dir do
    app_base_dir = File.join('/var/lib', Daddy.config.application)
    fail unless system("sudo mkdir -p #{app_base_dir}")
    fail unless system("sudo chown #{ENV['USER']}:#{ENV['USER']} #{app_base_dir}")
  end
end
