require_relative 'task_helper'

namespace :dad do
  namespace :unicorn do

    desc 'Unicornの設定を行います。'
    task :config do
      config = File.join('tmp', 'unicorn', 'unicorn.rb')
      render File.join(File.dirname(__FILE__), 'unicorn', 'unicorn.rb.erb'), :to => config

      init_script = File.join('tmp', 'unicorn', "unicorn_#{app_name}")
      render File.join(File.dirname(__FILE__), 'unicorn', 'unicorn.erb'), :to => init_script

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
        run "cp -f #{config} config/",
            "sudo cp -f #{init_script} /etc/init.d/",
            "sudo chown root:root /etc/init.d/#{File.basename(init_script)}",
            "sudo chmod 755 /etc/init.d/#{File.basename(init_script)}",
            "sudo /sbin/chkconfig #{File.basename(init_script)} on"
      end
    end  

  end
end
