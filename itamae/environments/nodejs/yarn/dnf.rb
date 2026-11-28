recipe_dir = ::File.dirname(::File.dirname(__FILE__))
yarn_yum_repo = ::File.join(recipe_dir, 'files/etc/yum.repos.d/yarn.repo')

execute 'place /etc/yum.repos.d/yarn.repo' do
  user 'root'
  command <<-EOF
    set -eu
    cp -f #{yarn_yum_repo} /etc/yum.repos.d/yarn.repo
    chmod 644 /etc/yum.repos.d/yarn.repo
  EOF
  not_if "diff #{yarn_yum_repo} /etc/yum.repos.d/yarn.repo"
end

package 'yarn' do
  user 'root'
  options '--enablerepo=yarn'
end

execute 'dnf clean all --enablerepo=yarn' do
  user 'root'
  action :nothing
  subscribes :run, 'package[yarn]', :immediately
end
