require 'daddy/itamae'

case dad_env
when 'production', 'development'
  directory '/var/lib' do
    user 'root'
  end
  directory File.join('/var/lib', Daddy.config.application) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
  directory File.join('/var/lib', Daddy.config.application, dad_env) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
when 'test'
  directory File.join('/tmp', Daddy.config.application) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
  directory File.join('/tmp', Daddy.config.application, dad_env) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
end
