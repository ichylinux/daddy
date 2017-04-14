require 'daddy/itamae'

package 'redis' do
  user 'root'
end

service 'redis' do
  user 'root'
  action [:enable, :start]
end
