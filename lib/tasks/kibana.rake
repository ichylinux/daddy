require_relative 'task_helper'

namespace :dad do
  namespace :kibana do

    desc "Kibanaをインストールします。"
    task :install do
      FileUtils.mkdir_p(File.join(rails_root, 'tmp'))

      script = File.join(File.dirname(__FILE__), 'kibana', 'install.sh')
      run "bash -x #{script}"
    end

  end
end
