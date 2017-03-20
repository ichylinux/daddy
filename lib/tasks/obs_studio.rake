require_relative 'task_helper'

namespace :dad do
  namespace :obs_studio do

    desc I18n.t('obs_studio.install')
    task :install do
      run_itamae 'obs_studio/install'
    end

  end
end