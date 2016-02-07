require 'rake'

namespace :dad do
  namespace :phantomjs do

    desc "PhantomJSをインストールします。"
    task :install do
      run_itamae 'phantomjs/install'
    end

  end
end
