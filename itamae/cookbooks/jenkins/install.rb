require 'daddy/itamae'

ENV['DAD_JENKINS_URL'] ||= 'http://localhost:8080'

@os_version = "#{node[:platform_family]}-#{node[:platform_version]}"
case @os_version
when /rhel-6\.(.*?)/
  package 'java-1.7.0-openjdk' do
    user 'root'
  end
when /rhel-7\.(.*?)/
  package 'java-1.8.0-openjdk' do
    user 'root'
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', :os_version => @os_version)
end

execute 'rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key' do
  user 'root'
  not_if 'test -e /etc/yum.repos.d/jenkins.repo'
end

http_request '/etc/yum.repos.d/jenkins.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  url 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
end

package 'jenkins' do
  user 'root'
end

template '/etc/sysconfig/jenkins' do
  user 'root'
  group 'root'
  owner 'root'
  mode '644'
end

service 'jenkins' do
  user 'root'
  action [:enable, :start]
end

execute "wait until jenkins starts" do
  command <<-EOF
    wget --retry-connrefused -t 10 #{ENV['DAD_JENKINS_URL']} ||
    wget -t 10 #{ENV['DAD_JENKINS_URL']} ||
    echo $?    
  EOF
end

directory '/var/lib/jenkins/.ssh' do
  user 'root'
  owner 'jenkins'
  group 'jenkins'
  mode '700'
end
  
execute "ssh-keygen -f id_rsa -q -N ''" do
  user 'jenkins'
  cwd '/var/lib/jenkins/.ssh'
  not_if 'test -e id_rsa'
end

file '/var/lib/jenkins/.ssh/authorized_keys' do
  user 'root'
end

%w{ authorized_keys id_rsa id_rsa.pub }.each do |name|
  file name do
    cwd '/var/lib/jenkins/.ssh'
    user 'root'
    owner 'jenkins'
    group 'jenkins'
    mode '600'
  end
end

execute 'add public key' do
  user 'root'
  cwd '/var/lib/jenkins/.ssh'
  command 'cat id_rsa.pub >> authorized_keys'
  not_if "cat authorized_keys | grep \"`cat id_rsa.pub`\""
end

execute '/etc/init.d/jenkins restart' do
  user 'root'
end

local_ruby_block 'post install message' do
  block do
    message = I18n.t('itamae.messages.jenkins.after_install',
        :jenkins_url => ENV['DAD_JENKINS_URL'],
        :public_key => `sudo cat /var/lib/jenkins/.ssh/id_rsa.pub`)
    message.split("\n").each do |line|
      Itamae.logger.info line
    end
  end
end
