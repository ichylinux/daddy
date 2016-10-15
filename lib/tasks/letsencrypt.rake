require_relative 'task_helper'

namespace :dad do
  namespace :letsencrypt do

    desc I18n.t('letsencrypt.install')
    task :install do
      run_itamae 'letsencrypt/install'
    end

  end
end