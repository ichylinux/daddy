require_relative 'task_helper'

namespace :dad do
  namespace :es do

    desc "Elasticsearchをインストールします。"
    task :install do
      @options = {
        :path_data => ask('path.data', :default => '/opt/elasticsearch/data')
      }

      template = File.join(File.dirname(__FILE__), 'elasticsearch', 'elasticsearch.yml.erb')
      render(template, :to => File.join('tmp', 'elasticsearch.yml'))

      script = File.join(File.dirname(__FILE__), 'elasticsearch', 'install.sh')
      run "bash -ex #{script}"
    end

  end
end
