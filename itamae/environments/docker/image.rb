version = ENV['CENTOS_VERSION'] || '7.6.1810'
dockerfile = File.join(File.dirname(__FILE__), 'centos', "Dockerfile.#{version}")

execute "install daddy on docker image" do
  command <<-EOF
    docker build -t centos-daddy:#{version} -f #{dockerfile} #{File.dirname(dockerfile)}
  EOF
end
