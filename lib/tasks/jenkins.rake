# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :jenkins do

    desc 'Jenkinsをインストールします。'
    task :install do
      [
        "sudo bash #{File.dirname(__FILE__)}/jenkins_install.sh",
        "sudo cp -f #{File.dirname(__FILE__)}/jenkins.conf /etc/httpd/conf.d",
        "sudo cp -f #{File.dirname(__FILE__)}/jenkins /etc/sysconfig",
        "sudo chown root:root /etc/sysconfig/jenkins",
        "sudo chmod 600 /etc/sysconfig/jenkins",
        "sudo mkdir -p /var/lib/jenkins/plugins",
        "sudo chown jenkins:jenkins /var/lib/jenkins/plugins",
      ].each do |command|
        puts command
        system(command)
      end

      plugins = [
        {:name => 'build-pipeline-plugin', :version => '1.3.3'},
        {:name => 'git', :version => '1.1.26'},
        {:name => 'rake', :version => '1.7.7'},
        {:name => 'rubyMetrics', :version => '1.5.0'},
        {:name => 'htmlpublisher', :version => '1.2'},
      ]
      plugins.each do |p|
        download_path = "tmp/#{p[:name]}.hpi"

        unless File.exist?(download_path)
          command = "sudo wget http://updates.jenkins-ci.org/download/plugins/#{p[:name]}/#{p[:version]}/#{p[:name]}.hpi -O #{download_path}"
          puts command
          system command
        end
        
        plugin_path = "/var/lib/jenkins/plugins/#{p[:name]}.hpi"
        system("sudo cp -f #{download_path} #{plugin_path}")
      end
    end

  end

end
