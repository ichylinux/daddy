require 'daddy/itamae'

include_recipe '../epel/install'

package 'redis' do
  user 'root'
end

service 'redis' do
  user 'root'
  action [:enable, :start]
end
