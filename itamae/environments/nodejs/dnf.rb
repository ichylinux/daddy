recipe_dir = ::File.dirname(__FILE__)
nodesource_yum_repo = ::File.join(recipe_dir, 'files/etc/yum.repos.d/nodesource-nodejs-v26.repo')
nodejs_version = '26.13.1-1nodesource'

execute 'place /etc/yum.repos.d/nodesource-nodejs.repo' do
  user 'root'
  command <<-EOF
    set -eu
    cp -f #{nodesource_yum_repo} /etc/yum.repos.d/nodesource-nodejs.repo
    chmod 644 /etc/yum.repos.d/nodesource-nodejs.repo
  EOF
  not_if "diff #{nodesource_yum_repo} /etc/yum.repos.d/nodesource-nodejs.repo"
end

package 'nodejs' do
  user 'root'
  version nodejs_version
  options '--enablerepo=nodesource-nodejs'
end

execute 'dnf clean all --enablerepo=nodesource-nodejs' do
  user 'root'
  action :nothing
  subscribes :run, 'package[nodejs]', :immediately
end
