require_relative 'task_helper'

namespace :dad do
  namespace :mysql do

    desc I18n.t('mysql.install')
    task :install do
      run_itamae 'mysql/install'
    end

  end
end
