require 'rake'

namespace :dad do
  namespace :god do

    desc "Godをインストールします。"
    task :install do
      run_itamae 'god/install'
    end

  end
end
