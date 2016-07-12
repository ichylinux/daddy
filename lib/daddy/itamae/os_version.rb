def os_version
  ENV['DAD_OS_VERSION'] ||= "#{node[:platform_family]}-#{node[:platform_version]}"
end
