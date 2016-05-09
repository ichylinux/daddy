require_relative 'task_helper'

namespace :dad do
  namespace :jenkins do

    desc I18n.t('jenkins.install')
    task :install do
      run_itamae 'jenkins/install'
    end

    namespace :nginx do
      desc 'Nginxの設定を行います'
      task :config do
        @server_name = ask('server_name', :required => true)
        @ssl_certificate = ask('ssl_certificate')
        @ssl_certificate_key = ask('ssl_certificate_key')

        FileUtils.mkdir_p 'tmp'
        template = File.join(File.dirname(__FILE__), 'jenkins', 'nginx.conf.erb')
        render template, :to => 'tmp/jenkins_nginx.conf'

        run "sudo cp -f tmp/jenkins_nginx.conf /etc/nginx/conf.d/servers/jenkins.conf"
      end
    end

    namespace :plugins do
      desc I18n.t('jenkins.plugins.install')
      task :install do
        run_itamae 'jenkins/plugins/install'
      end
    end

  end
end
