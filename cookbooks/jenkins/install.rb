ENV['DAD_JENKINS_URL'] ||= 'http://localhost:8080'

package 'java-1.8.0-openjdk' do
  user 'root'
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
  source File.join(File.dirname(__FILE__), 'jenkins.erb')
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
  {:name => 'build-pipeline-plugin', :version => '1.4.3'},
  {:name => 'git', :version => '2.2.5'},
  {:name => 'git-client', :version => '1.10.2'},
  {:name => 'rake', :version => '1.8.0'},
  {:name => 'rubyMetrics', :version => '1.6.2'},
  {:name => 'htmlpublisher', :version => '1.3'},
  {:name => 'reverse-proxy-auth-plugin', :version => '1.4.0'},
  {:name => 'thinBackup', :version => '1.7.4'}
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