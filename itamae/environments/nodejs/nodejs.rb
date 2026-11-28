recipe_dir = ::File.dirname(__FILE__)
nodesource_yum_repo = ::File.join(recipe_dir, 'files/etc/yum.repos.d/nodesource-nodejs-v26.repo')
nodesource_deb_repo = ::File.join(recipe_dir, 'files/etc/apt/sources.list.d/nodesource-nodejs-v26.sources')
nodejs_pin = ::File.join(recipe_dir, 'files/etc/apt/preferences.d/nodejs')
nsolid_pin = ::File.join(recipe_dir, 'files/etc/apt/preferences.d/nsolid')
debian = ::File.exist?('/etc/debian_version')

execute 'place /etc/yum.repos.d/nodesource-nodejs.repo' do
  user 'root'
  command <<-EOF
    set -eu
    sudo cp -f #{nodesource_yum_repo} /etc/yum.repos.d/nodesource-nodejs.repo
    sudo chmod 644 /etc/yum.repos.d/nodesource-nodejs.repo
  EOF
  only_if 'test -f /etc/redhat-release'
  not_if "diff #{nodesource_yum_repo} /etc/yum.repos.d/nodesource-nodejs.repo"
end

execute 'place /usr/share/keyrings/nodesource.gpg' do
  user 'root'
  command <<-EOF
    set -eu
    sudo mkdir -p /usr/share/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/nodesource.gpg > /dev/null
    sudo chmod 644 /usr/share/keyrings/nodesource.gpg
  EOF
  only_if 'test -f /etc/debian_version'
  not_if 'test -s /usr/share/keyrings/nodesource.gpg'
end

execute 'place nodesource apt repository' do
  user 'root'
  command <<-EOF
    set -eu
    sudo mkdir -p /etc/apt/sources.list.d /etc/apt/preferences.d
    sudo cp -f #{nodesource_deb_repo} /etc/apt/sources.list.d/nodesource.sources
    sudo chmod 644 /etc/apt/sources.list.d/nodesource.sources
    sudo cp -f #{nodejs_pin} /etc/apt/preferences.d/nodejs
    sudo chmod 644 /etc/apt/preferences.d/nodejs
    sudo cp -f #{nsolid_pin} /etc/apt/preferences.d/nsolid
    sudo chmod 644 /etc/apt/preferences.d/nsolid
  EOF
  only_if 'test -f /etc/debian_version'
  not_if "diff #{nodesource_deb_repo} /etc/apt/sources.list.d/nodesource.sources"
end

execute 'apt-get update (nodesource-nodejs)' do
  user 'root'
  command 'apt-get update'
  only_if 'test -f /etc/debian_version'
  action :nothing
  subscribes :run, 'execute[place nodesource apt repository]', :immediately
end

package 'nodejs' do
  user 'root'
  version debian ? '26.13.1-1nodesource1' : '26.13.1-1nodesource'
  options '--enablerepo=nodesource-nodejs' unless debian
end

execute 'dnf clean all --enablerepo=nodesource-nodejs' do
  user 'root'
  only_if 'test -f /etc/redhat-release'
  action :nothing
  subscribes :run, 'package[nodejs]', :immediately
end