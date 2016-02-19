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

http_request '/etc/yum.repos.d/jenkins.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  url 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
end

execute 'rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key' do
  user 'root'
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

directory 'tmp'

execute "wait until jenkins starts" do
  cwd 'tmp'
  command <<-EOF
    wget --retry-connrefused -t 10 #{ENV['DAD_JENKINS_URL']} ||
    wget -t 10 #{ENV['DAD_JENKINS_URL']} ||
    echo $?    
  EOF
end

execute 'wget jenkins-cli.jar' do
  cwd 'tmp'
  command "wget #{ENV['DAD_JENKINS_URL']}/jnlpJars/jenkins-cli.jar"
  not_if 'test -e jenkins-cli.jar'
end

directory '/var/lib/jenkins/plugins' do
  user 'root'
  group 'jenkins'
  owner 'jenkins'
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
