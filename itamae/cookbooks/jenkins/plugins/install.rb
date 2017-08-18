require 'daddy/itamae'

ENV['DAD_JENKINS_URL'] ||= 'http://localhost:8080'

execute 'wget jenkins-cli.jar' do
  cwd '/tmp'
  command "wget #{ENV['DAD_JENKINS_URL']}/jnlpJars/jenkins-cli.jar"
  not_if 'test -e jenkins-cli.jar'
end

directory '/var/lib/jenkins/plugins' do
  user 'root'
  group 'jenkins'
  owner 'jenkins'
end

@plugins = [
  {:name => 'ansicolor', :version => nil},
  {:name => 'build-pipeline-plugin', :version => nil},
  {:name => 'rake', :version => nil},
  {:name => 'rubyMetrics', :version => nil},
  {:name => 'htmlpublisher', :version => nil},
  {:name => 'thinBackup', :version => nil}
]
@plugins.each do |plugin|
  options = "-s #{ENV['DAD_JENKINS_URL']} -i /var/lib/jenkins/.ssh/id_rsa"
  execute "/var/lib/jenkins/plugins/#{plugin[:name]}" do
    cwd '/tmp'
    user 'jenkins'
    command "java -jar jenkins-cli.jar #{options} install-plugin #{plugin[:name]}"
    not_if "java -jar jenkins-cli.jar #{options} list-plugins | grep #{plugin[:name]}"
  end
end

execute 'restart jenkins' do
  cwd '/tmp'
  user 'jenkins'
  command "java -jar jenkins-cli.jar -s #{ENV['DAD_JENKINS_URL']} -i /var/lib/jenkins/.ssh/id_rsa safe-restart"
end
