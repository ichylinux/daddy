dockerfile = File.join(File.dirname(__FILE__), 'Dockerfile.base')
execute "docker build -t daddy-base:latest -f #{dockerfile} #{File.dirname(dockerfile)}/" do
  not_if "docker images | grep daddy-base"
end
