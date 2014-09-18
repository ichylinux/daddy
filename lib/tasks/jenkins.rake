require_relative 'task_helper'

namespace :dad do
  namespace :jenkins do

    desc 'Jenkinsをインストールします。'
    task :install do
      FileUtils.mkdir_p 'tmp'

      script = File.join(File.dirname(__FILE__), 'jenkins', 'install.sh')
      run "bash -ex #{script}"

      plugins = [
        {:name => 'build-pipeline-plugin', :version => '1.4.3'},
        {:name => 'git', :version => '2.2.5'},
        {:name => 'git-client', :version => '1.10.2'},
        {:name => 'rake', :version => '1.8.0'},
        {:name => 'rubyMetrics', :version => '1.6.2'},
        {:name => 'htmlpublisher', :version => '1.3'},
        {:name => 'reverse-proxy-auth-plugin', :version => '1.4.0'},
        {:name => 'thinBackup', :version => '1.7.4'}
      ]
      plugins.each do |p|
        download_path = "tmp/#{p[:name]}-#{p[:version]}.hpi"
        unless File.exist?(download_path)
          run "sudo wget http://updates.jenkins-ci.org/download/plugins/#{p[:name]}/#{p[:version]}/#{p[:name]}.hpi -O #{download_path}"
        end
        
        run "sudo cp -f #{download_path} /var/lib/jenkins/plugins/#{p[:name]}.hpi"
      end
    end

    namespace :nginx do
      desc 'Nginxの設定を行います。'
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

  end
end
