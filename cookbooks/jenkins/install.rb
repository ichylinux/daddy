directory 'tmp'

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

directory '/var/lib/jenkins/plugins' do
  user 'root'
  group 'jenkins'
  owner 'jenkins'
end

template '/etc/sysconfig/jenkins' do
  source File.join(File.dirname(__FILE__), 'jenkins.erb')
  user 'root'
  group 'root'
  owner 'root'
  mode '644'
end