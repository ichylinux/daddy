require_relative 'task_helper'

namespace :dad do
  namespace :kibana do

    desc "Kibanaをインストールします。"
    task :install do
      @options = {
        :version => ask('version', :default => '3.1.2'),
        :server => ask('server', :default => 'localhost')
      }
      render(task_file('kibana', 'config.js.erb'), :to => 'tmp/config.js')
      render(task_file('kibana', 'nginx.conf.erb'), :to => 'tmp/nginx/kibana.conf')

      run "bash -ex #{task_file('kibana', 'configure.sh')} #{@options[:version]}"
      run "bash -ex #{task_file('kibana', 'install.sh')} #{@options[:version]}" unless ENV['DRY_RUN']
    end

  end
end
