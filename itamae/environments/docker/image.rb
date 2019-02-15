dockerfile = File.join(File.dirname(__FILE__), 'Dockerfile.base')
execute "docker build -t daddy-base:latest -f #{dockerfile} #{File.dirname(dockerfile)}"
