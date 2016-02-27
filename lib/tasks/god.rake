require 'rake'

namespace :dad do
  namespace :god do

    desc I18n.t('god.install')
    task :install do
      run_itamae 'god/install'
    end

  end
end
