execute 'place /etc/yum.repos.d/yarn.repo' do
  user 'root'
  command <<-EOF
    set -eu
    sudo cp -f #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/yarn.repo')} /etc/yum.repos.d/yarn.repo
    sudo chmod 644 /etc/yum.repos.d/yarn.repo
  EOF
  not_if "diff #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/yarn.repo')} /etc/yum.repos.d/yarn.repo"
end

package 'yarn' do
  user 'root'
  options '--enablerepo=yarn'
end

execute 'dnf clean all --enablerepo=yarn' do
  user 'root'
  action :nothing
  subscribes :run, "package[yarn]", :immediately
end
