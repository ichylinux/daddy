require_relative 'task_helper'

namespace :dad do
  namespace :git do

    desc I18n.t('git.install')
    task :install do
      run_itamae 'git/install'
    end

  end
end
