require_relative 'task_helper'

namespace :dad do
  namespace :kibana do

    desc "Kibanaをインストールします。"
    task :install do
      @options = {
        :version => ask('version', :default => '3.1.2'),
        :elasticsearch => ask('elasticsearch', :default => '"https://" + window.location.hostname')
      }
      render(task_file('kibana', 'config.js.erb'), :to => 'tmp/config.js')

      run "bash -ex #{task_file('kibana', 'configure.sh')} #{@options[:version]}"
      run "bash -ex #{task_file('kibana', 'install.sh')} #{@options[:version]}" unless ENV['DRY_RUN']
    end

  end
end
