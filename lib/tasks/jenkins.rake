# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :jenkins do

    task :install do
      [
        "sudo bash #{File.dirname(__FILE__)}/jenkins_install.sh",
        "sudo cp -f #{File.dirname(__FILE__)}/jenkins.conf /etc/httpd/conf.d",
        "sudo cp -f #{File.dirname(__FILE__)}/jenkins /etc/sysconfig",
        "sudo chown root:root /etc/sysconfig/jenkins",
        "sudo chmod 600 /etc/sysconfig/jenkins",
        "sudo wget http://updates.jenkins-ci.org/download/plugins/git/1.1.26/git.hpi -O /var/lib/jenkins/plugins/git.hpi",
      ].each do |command|
        puts command
        system(command)
      end
    end

  end

end
