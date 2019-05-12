require_relative 'task_helper'

namespace :dad do

  namespace :nginx do
    namespace :config do

      desc I18n.t('nginx.config.gitbucket')
      task :gitbucket do
        ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
        ENV['PORT'] = ask('PORT', :default => '8081', :required => true)
        run_itamae 'nginx/config/gitbucket'
      end

      desc I18n.t('nginx.config.jenkins')
      task :jenkins do
        ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
        run_itamae 'nginx/config/jenkins'
      end

      desc I18n.t('nginx.config.rails')
      task :rails do
        ENV['APP_NAME'] ||= app_name
        ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
        ENV['RAILS_ENV'] ||= rails_env(:default => 'development')
        ENV['RAILS_ROOT'] ||= rails_root
        run_itamae 'nginx/config/rails'
      end

    end
  end
end
