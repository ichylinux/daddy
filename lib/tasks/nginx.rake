require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc I18n.t('nginx.install')
    task :install do
      run_itamae 'nginx/install'
    end

    desc 'Nginxにアプリの設定ファイルをインストールします。'
    task :config do
      @server_name = ENV['SERVER_NAME'] || ask('SERVER_NAME', :default => 'localhost', :required => true)
      @rails_env = rails_env(:default => 'production')
      app_conf = render File.join(File.dirname(__FILE__), 'nginx', 'app.conf.erb'),
          :to => "tmp/daddy/nginx/#{app_name}.conf"

      unless dry_run?
        run "sudo mkdir -p /etc/nginx/conf.d/servers",
            "sudo cp -f #{app_conf.path} /etc/nginx/conf.d/servers/"
      end
    end

  end
end
