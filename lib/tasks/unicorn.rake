require_relative 'task_helper'

namespace :dad do
  namespace :unicorn do

    desc I18n.t('unicorn.install')
    task :install do
      ENV['APP_NAME'] ||= app_name
      ENV['RAILS_ENV'] ||= rails_env(:default => 'development')
      ENV['RAILS_ROOT'] ||= rails_root
      run_itamae 'unicorn/install'
    end

  end
end
