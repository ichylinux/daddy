require 'daddy/itamae'

version = ENV['MONGO_VERSION'] || '3.6'

template '/etc/yum.repos.d/mongodb-org.repo' do
  user 'root'
  variables :version => version
end

package 'mongodb-org' do
  user 'root'
end

service 'mongod' do
  user 'root'
  action ['enable', 'start']
end
