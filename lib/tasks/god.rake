require 'rake'

namespace :dad do
  namespace :god do

    desc "Godをインストールします。"
    task :install do
      script = File.join(File.dirname(__FILE__), 'god', 'install.sh')
      system("bash -x #{script} #{rails_env} #{rails_root}")
    end

  end
end
