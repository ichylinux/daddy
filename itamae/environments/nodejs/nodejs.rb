case node[:platform]
when 'almalinux'
  execute 'place /etc/yum.repos.d/nodesource-nodejs.repo' do
    user 'root'
    command <<-EOF
      set -eu
      sudo cp -f #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs-v22.repo')} /etc/yum.repos.d/nodesource-nodejs.repo
      sudo chmod 644 /etc/yum.repos.d/nodesource-nodejs.repo
    EOF
    not_if "diff #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs-v22.repo')} /etc/yum.repos.d/nodesource-nodejs.repo"
  end
  
  package 'nodejs' do
    user 'root'
    version '22.22.2-1nodesource'
    options '--enablerepo=nodesource-nodejs'
  end
  
  execute 'dnf clean all --enablerepo=nodesource-nodejs' do
    user 'root'
    action :nothing
    subscribes :run, "package[nodejs]", :immediately
  end
when 'amazon'
  execute 'place /etc/yum.repos.d/nodesource-nodejs.repo' do
    user 'root'
    command <<-EOF
      set -eu
      sudo cp -f #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs-v18.repo')} /etc/yum.repos.d/nodesource-nodejs.repo
      sudo chmod 644 /etc/yum.repos.d/nodesource-nodejs.repo
    EOF
    not_if "diff #{::File.join(::File.dirname(__FILE__), 'files/etc/yum.repos.d/nodesource-nodejs-v18.repo')} /etc/yum.repos.d/nodesource-nodejs.repo"
  end
  
  package 'nodejs' do
    user 'root'
    version '18.20.8-1nodesource'
    options '--enablerepo=nodesource-nodejs'
  end
  
  execute 'yum clean all --enablerepo=nodesource-nodejs' do
    user 'root'
    action :nothing
    subscribes :run, "package[nodejs]", :immediately
  end
end
