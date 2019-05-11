require_relative 'task_helper'

namespace :dad do

  desc I18n.t('redmine.install')
  task :redmine do
    run_itamae 'redmine'
  end

end
