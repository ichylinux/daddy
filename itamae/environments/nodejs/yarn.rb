recipe_dir = ::File.dirname(__FILE__)
yarn_yum_repo = ::File.join(recipe_dir, 'files/etc/yum.repos.d/yarn.repo')
yarn_deb_repo = ::File.join(recipe_dir, 'files/etc/apt/sources.list.d/yarn.list')

execute 'place /etc/yum.repos.d/yarn.repo' do
  user 'root'
  command <<-EOF
    set -eu
    sudo cp -f #{yarn_yum_repo} /etc/yum.repos.d/yarn.repo
    sudo chmod 644 /etc/yum.repos.d/yarn.repo
  EOF
  only_if 'test -f /etc/redhat-release'
  not_if "diff #{yarn_yum_repo} /etc/yum.repos.d/yarn.repo"
end

execute 'place /usr/share/keyrings/yarn.gpg' do
  user 'root'
  command <<-EOF
    set -eu
    sudo mkdir -p /usr/share/keyrings
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarn.gpg > /dev/null
    sudo chmod 644 /usr/share/keyrings/yarn.gpg
  EOF
  only_if 'test -f /etc/debian_version'
  not_if 'test -s /usr/share/keyrings/yarn.gpg'
end

execute 'place yarn apt repository' do
  user 'root'
  command <<-EOF
    set -eu
    sudo mkdir -p /etc/apt/sources.list.d
    sudo cp -f #{yarn_deb_repo} /etc/apt/sources.list.d/yarn.list
    sudo chmod 644 /etc/apt/sources.list.d/yarn.list
  EOF
  only_if 'test -f /etc/debian_version'
  not_if "diff #{yarn_deb_repo} /etc/apt/sources.list.d/yarn.list"
end

execute 'apt-get update (yarn)' do
  user 'root'
  command 'apt-get update'
  only_if 'test -f /etc/debian_version'
  action :nothing
  subscribes :run, 'execute[place yarn apt repository]', :immediately
end

package 'yarn' do
  user 'root'
  options '--enablerepo=yarn' unless ::File.exist?('/etc/debian_version')
end

execute 'dnf clean all --enablerepo=yarn' do
  user 'root'
  only_if 'test -f /etc/redhat-release'
  action :nothing
  subscribes :run, 'package[yarn]', :immediately
end