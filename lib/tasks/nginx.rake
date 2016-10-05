require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc I18n.t('nginx.install')
    task :install do
      run_itamae 'nginx/install'
    end

    desc 'Nginxにアプリの設定ファイルをインストールします。'
    task :config do
      ENV['APP_NAME'] ||= app_name
      ENV['SERVER_NAME'] ||= ask('SERVER_NAME', :default => 'localhost', :required => true)
      ENV['RAILS_ENV'] ||= rails_env(:default => 'development')
      ENV['RAILS_ROOT'] ||= rails_root
      run_itamae 'nginx/app'
    end

  end
end
