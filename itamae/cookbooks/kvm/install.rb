%w{
  qemu-kvm qemu-img libvirt libvirt-client libvirt-python libguestfs-tools virt-install virt-manager virt-viewer
}.each do |name|
  package name do
    user 'root'
  end
end

service 'libvirtd' do
  user 'root'
  action [:enable, :start]
end
