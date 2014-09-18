require_relative 'task_helper'

namespace :dad do
  namespace :jenkins do

    desc 'Jenkinsをインストールします。'
    task :install do
      FileUtils.mkdir_p 'tmp'

      script = File.join(File.dirname(__FILE__), 'jenkins', 'install.sh')
      fail unless system "bash -ex #{script}"

      plugins = [
        {:name => 'build-pipeline-plugin', :version => '1.4.3'},
        {:name => 'git', :version => '2.2.5'},
        {:name => 'git-client', :version => '1.10.2'},
        {:name => 'rake', :version => '1.8.0'},
        {:name => 'rubyMetrics', :version => '1.6.2'},
        {:name => 'htmlpublisher', :version => '1.3'},
        {:name => 'reverse-proxy-auth-plugin', :version => '1.4.0'}
      ]
      plugins.each do |p|
        download_path = "tmp/#{p[:name]}-#{p[:version]}.hpi"

        unless File.exist?(download_path)
          command = "sudo wget http://updates.jenkins-ci.org/download/plugins/#{p[:name]}/#{p[:version]}/#{p[:name]}.hpi -O #{download_path}"
          puts command
          fail unless system(command)
        end
        
        command = "sudo cp -f #{download_path} /var/lib/jenkins/plugins/#{p[:name]}.hpi"
        puts command
        fail unless system(command)
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
