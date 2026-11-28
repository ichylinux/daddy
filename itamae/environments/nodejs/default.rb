nodejs_dir = ::File.dirname(__FILE__)
include_recipe ::File.expand_path('../lib/pkg_platform.rb', nodejs_dir)

case node[:pkg_platform]
when :debian
  include_recipe ::File.join(nodejs_dir, 'apt.rb')
when :redhat
  include_recipe ::File.join(nodejs_dir, 'dnf.rb')
else
  raise "サポートしていないプラットフォームです: #{node[:pkg_platform].inspect}"
end

include_recipe 'yarn'
