require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc I18n.t('nginx.install')
    task :install do
      run_itamae 'nginx/install'
    end

    desc I18n.t('nginx.config.default')
    task :config do
      ENV['APP_NAME'] ||= app_name
      ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
      ENV['RAILS_ENV'] ||= rails_env(:default => 'development')
      ENV['RAILS_ROOT'] ||= rails_root
      run_itamae 'nginx/config'
    end

    namespace :config do

      desc I18n.t('nginx.config.gitbucket')
      task :jenkins do
        ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
        ENV['PORT'] = ask('PORT', :default => '8081', :required => true)
        run_itamae 'nginx/config/gitbucket'
      end

      desc I18n.t('nginx.config.jenkins')
      task :jenkins do
        ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
        run_itamae 'nginx/config/jenkins'
      end

    end
  end
end
