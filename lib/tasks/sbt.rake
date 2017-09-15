require_relative 'task_helper'

namespace :dad do
  namespace :sbt do

    desc I18n.t('sbt.install')
    task :install do
      run_itamae 'sbt/install'
    end

  end
end
