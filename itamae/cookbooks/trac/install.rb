require 'daddy/itamae'

package 'python2-pip' do
  user 'root'
end

package 'python-devel' do
  user 'root'
end

{
  'Trac': '1.2.2',
  'MySQL-python': nil,
  'trac-github': nil,
  'requests-oauthlib': nil
}.each do |name, version|
  execute "pip install #{name}" do
    user 'root'
    not_if "pip list --format=freeze | egrep '#{name}==#{version ? version : '.*'}'"
  end
end

directory '/var/apps' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

directory '/var/apps/trac' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end