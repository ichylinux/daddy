def os_version
  @_os_version ||= "#{node[:platform_family]}-#{node[:platform_version]}"
end
