require 'rake'
require 'yaml'

namespace :dad do
  namespace :resque do

    desc "Resqueをインストールします。"
    task :install => :environment do
      rails_root = ENV['RAILS_ROOT'] || Rails.root
      app_name = YAML.load_file("#{rails_root}/config/database.yml")[Rails.env]['database']

      script = <<-EOF
#!/bin/bash

export APP_NAME=#{app_name}
export RAILS_ROOT=#{rails_root}
export RAILS_ENV=#{Rails.env}
export NUM_WORKERS=1
erb -T - #{File.join(File.dirname(__FILE__), 'resque.erb')} > tmp/#{app_name}.god 

sudo mkdir -p /etc/god
sudo cp -f tmp/#{app_name}.god /etc/god/#{app_name}.god
sudo chown -R root:root /etc/god
sudo chmod 755 /etc/god
sudo chmod -R 644 /etc/god/*

sudo /etc/init.d/god restart
EOF

      tmpfile = File.join(Rails.root, 'tmp', 'dad-resque-install-' + Daddy::Utils::StringUtils.current_time + '.sh')
      File.write(tmpfile, ERB.new(script).result)
      fail unless system("bash #{tmpfile}")
    end

  end
end

require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque/scheduler'

    # If you want to be able to dynamically change the schedule,
    # uncomment this line.  A dynamic schedule can be updated via the
    # Resque::Scheduler.set_schedule (and remove_schedule) methods.
    # When dynamic is set to true, the scheduler process looks for
    # schedule changes and applies them on the fly.
    # Note: This feature is only available in >=2.0.0.
    Resque::Scheduler.dynamic = true

    # The schedule doesn't need to be stored in a YAML, it just needs to
    # be a hash.  YAML is usually the easiest.
    #Resque.schedule = YAML.load_file('your_resque_schedule.yml')

    # If your schedule already has +queue+ set for each job, you don't
    # need to require your jobs.  This can be an advantage since it's
    # less code that resque-scheduler needs to know about. But in a small
    # project, it's usually easier to just include you job classes here.
    # So, something like this:
    #require 'jobs'
  end
end
