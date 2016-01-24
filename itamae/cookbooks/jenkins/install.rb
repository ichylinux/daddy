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
  raise "サポートしていないOSバージョンです。#{@os_version}"
end

execute '/etc/yum.repos.d/jenkins.repo' do
  user 'root'
  command <<-EOF
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
  EOF
  not_if 'test -e /etc/yum.repos.d/jenkins.repo'
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

directory '/var/lib/jenkins/plugins' do
  user 'root'
  group 'jenkins'
  owner 'jenkins'
end

directory 'tmp'

execute 'jenkins-cli.jar' do
  cwd 'tmp'
  command "wget #{ENV['DAD_JENKINS_URL']}/jnlpJars/jenkins-cli.jar"
  not_if 'test -e jenkins-cli.jar'
end

@plugins = [
  {:name => 'build-pipeline-plugin', :version => nil},
  {:name => 'git', :version => nil},
  {:name => 'git-client', :version => nil},
  {:name => 'rake', :version => nil},
  {:name => 'rubyMetrics', :version => nil},
  {:name => 'htmlpublisher', :version => nil},
  {:name => 'reverse-proxy-auth-plugin', :version => nil},
  {:name => 'thinBackup', :version => nil}
]
@plugins.each do |plugin|
  execute "/var/lib/jenkins/plugins/#{plugin[:name]}" do
    cwd 'tmp'
    command "java -jar jenkins-cli.jar -s #{ENV['DAD_JENKINS_URL']} install-plugin #{plugin[:name]}"
  end
end

execute 'restart jenkins' do
  cwd 'tmp'
  command "java -jar jenkins-cli.jar -s #{ENV['DAD_JENKINS_URL']} safe-restart"
end
