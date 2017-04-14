require_relative 'task_helper'

namespace :dad do
  namespace :memcached do

    desc I18n.t('memcached.install')
    task :install do
      run_itamae 'memcached/install'
    end

  end
end
