# Detects the package-manager platform of the machine being set up and exposes
# it as node[:pkg_platform] (:debian or :redhat).
#
# node attributes are preferred because `itamae docker --ohai` reports the
# target container platform, while the marker files are read on the host.
# `mitamae local` does not populate platform_family, so node attributes are
# not always available and the marker files are used as a fallback.
families = [node[:platform_family], node[:platform]].map { |v| v.to_s }.reject { |v| v.empty? }
debian = families.any? { |f| %w[debian ubuntu linuxmint].include?(f) }
redhat = families.any? { |f| %w[redhat rhel centos fedora almalinux rocky].include?(f) }

unless debian || redhat
  debian = ::File.exist?('/etc/debian_version')
  redhat = ::File.exist?('/etc/redhat-release')
end

node[:pkg_platform] = if debian && redhat
  raise "Debian 系と Red Hat 系のプラットフォームが混在しています: #{families.join(', ')}"
elsif debian
  :debian
elsif redhat
  :redhat
else
  raise 'サポートしていないプラットフォームです（Debian 系または Red Hat 系のみ対応）'
end
