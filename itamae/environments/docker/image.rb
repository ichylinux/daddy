dockerfile = File.join(File.dirname(__FILE__), 'Dockerfile.base')
execute "docker build -t daddy-base:latest --build-arg user=#{ENV['USER']} -f #{dockerfile} #{File.dirname(dockerfile)}/" do
  not_if "docker images | grep daddy-base"
end
