dockerfile = File.join(File.dirname(__FILE__), 'Dockerfile.base')
image = 'daddy-base'

execute "docker build -t #{image}:latest -f #{dockerfile} #{File.dirname(dockerfile)}"

execute "bundle exec itamae docker --image=#{image}:latest --tag=#{image}:latest itamae/environments/base/install.rb"
