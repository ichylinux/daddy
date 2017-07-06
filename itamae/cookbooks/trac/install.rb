require 'daddy/itamae'

package 'python2-pip' do
  user 'root'
end

package 'python-devel' do
  user 'root'
end

execute 'pip install trac==1.2.2 mysql-python' do
  user 'root'
end