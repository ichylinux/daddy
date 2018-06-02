execute 'yum -y groupinstall "Development Tools"' do
  user 'root'
end

include_recipe '../cookbooks/ruby/install'
