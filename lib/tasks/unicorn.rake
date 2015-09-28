require_relative 'task_helper'

namespace :dad do
  namespace :unicorn do

    desc 'Unicornの設定を行います。'
    task :config do
      config = render File.join(File.dirname(__FILE__), 'unicorn', 'unicorn.rb.erb'),
          :to => File.join('tmp', 'unicorn', 'unicorn.rb')

      init_script = render File.join(File.dirname(__FILE__), 'unicorn', 'unicorn.erb'),
          :to => File.join('tmp', 'unicorn', "unicorn_#{app_name}")

      if dry_run?
        puts "----------------------------------------"
        puts config
        puts "----------------------------------------"
        puts File.read(config)
        puts "----------------------------------------"
        puts init_script
        puts "----------------------------------------"
        puts File.read(init_script)
        puts "----------------------------------------"
      else
        run "cp -f #{config.path} config/",
            "sudo cp -f #{init_script.path} /etc/init.d/",
            "sudo chown root:root /etc/init.d/#{File.basename(init_script.path)}",
            "sudo chmod 755 /etc/init.d/#{File.basename(init_script.path)}",
            "sudo /sbin/chkconfig #{File.basename(init_script.path)} on"
      end
    end  

  end
end
