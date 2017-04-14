require 'daddy/itamae'

package 'memcached' do
  user 'root'
end

service 'memcached' do
  user 'root'
  action [:enable, :start]
end
