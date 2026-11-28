yarn_dir = ::File.dirname(__FILE__)

case node[:pkg_platform]
when :debian
  include_recipe ::File.join(yarn_dir, 'apt.rb')
when :redhat
  include_recipe ::File.join(yarn_dir, 'dnf.rb')
else
  raise "サポートしていないプラットフォームです: #{node[:pkg_platform].inspect}"
end
