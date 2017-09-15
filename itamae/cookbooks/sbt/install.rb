directory 'tmp'

execute 'download repo definition' do
  cwd 'tmp'
  command <<-EOF
    curl https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo
    sudo mv bintray-sbt-rpm.repo /etc/yum.repos.d/
  EOF
  not_if 'test -e /etc/yum.repos.d/bintray-sbt-rpm.repo'
end

package 'sbt' do
  user 'root'
end
