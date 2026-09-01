execute 'place /etc/yum.repos.d/nodesource-nodejs.repo' do
  user 'root'
  command <<-EOF
    set -eu
    sudo cp -f #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs-v24.repo')} /etc/yum.repos.d/nodesource-nodejs.repo
    sudo chmod 644 /etc/yum.repos.d/nodesource-nodejs.repo
  EOF
  not_if "diff #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs-v24.repo')} /etc/yum.repos.d/nodesource-nodejs.repo"
end

package 'nodejs' do
  user 'root'
  version '24.20.0-1nodesource'
  options '--enablerepo=nodesource-nodejs'
end

execute 'dnf clean all --enablerepo=nodesource-nodejs' do
  user 'root'
  action :nothing
  subscribes :run, "package[nodejs]", :immediately
end
