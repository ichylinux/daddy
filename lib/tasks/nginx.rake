require_relative 'task_helper'

namespace :dad do
  namespace :nginx do

    desc 'Nginxをインストールします。'
    task :install do
      repo = File.join(File.dirname(__FILE__), 'nginx', 'nginx.repo')
      run "sudo cp -f #{repo} /etc/yum.repos.d/"

      options = []
      options << '-y'
      options << '-q' if quiet?
      run "sudo yum #{options.join(' ')} install nginx"

      empty_conf = render File.join(File.dirname(__FILE__), 'nginx', 'empty.conf.erb'),
          :to => 'tmp/daddy/nginx/emtpy.conf'

      default_config_files = [
        '/etc/nginx/conf.d/default.conf',
        '/etc/nginx/conf.d/example_ssl.conf'
      ]
      default_config_files.each do |conf|
        if File.exist?(conf)
          run "sudo mv #{conf} #{conf}.org" unless File.exist?("#{conf}.org")
          run "sudo cp -f #{empty_conf.path} #{conf}"
        end
      end

      nginx_conf = render File.join(File.dirname(__FILE__), 'nginx', 'nginx.conf.erb'),
          :to => 'tmp/daddy/nginx/nginx.conf'
      run "sudo cp -f #{nginx_conf.path} /etc/nginx/conf.d/nginx.conf",
          "sudo mkdir -p /etc/nginx/conf.d/servers"
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
