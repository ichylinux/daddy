require_relative 'task_helper'

namespace :dad do
  namespace :trac do

    desc I18n.t('trac.install')
    task :install do
      run_itamae 'trac/install'
    end

  end
end
