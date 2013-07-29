# coding: UTF-8

require 'rake'
require 'term/ansicolor'
include Term::ANSIColor

namespace :dad do
  namespace :jenkins do

    desc 'Jenkinsをインストールします。'
    task :install do
      commands = [
        "sudo yum install httpd-devel libxslt-devel libxml2-devel java-1.7.0-openjdk qt-webkit-devel Xvfb firefox",
        "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo",
        "sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key",
        "sudo yum install jenkins",
        "sudo cp -f #{File.dirname(__FILE__)}/jenkins.conf /etc/httpd/conf.d",
        "sudo cp -f #{File.dirname(__FILE__)}/jenkins /etc/sysconfig",
        "sudo chown root:root /etc/sysconfig/jenkins",
        "sudo chmod 600 /etc/sysconfig/jenkins",
        "sudo mkdir -p /var/lib/jenkins/plugins",
        "sudo chown jenkins:jenkins /var/lib/jenkins/plugins",
      ]
      commands.each do |command|
        print blue, bold, command, reset, "\n"
        system(command)
      end

      plugins = [
        {:name => 'build-pipeline-plugin', :version => '1.3.5'},
        {:name => 'git', :version => '1.4.0'},
        {:name => 'rake', :version => '1.7.7'},
        {:name => 'rubyMetrics', :version => '1.5.0'},
        {:name => 'htmlpublisher', :version => '1.2'},
      ]
      plugins.each do |p|
        download_path = "tmp/#{p[:name]}.hpi"

        unless File.exist?(download_path)
          command = "sudo wget http://updates.jenkins-ci.org/download/plugins/#{p[:name]}/#{p[:version]}/#{p[:name]}.hpi -O #{download_path}"
          print blue, bold, command, reset, "\n"
          system(command)
        end
        
        command = "sudo cp -f #{download_path} /var/lib/jenkins/plugins/#{p[:name]}.hpi"
        print blue, bold, command, reset, "\n"
        system(command)
      end
    end

  end

end
