require 'daddy/itamae'

case dad_env
when 'production'
  directory '/data' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
  directory File.join('/data', app_name) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end

  directory '/var/apps' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
  directory File.join('/var/apps', app_name) do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end

  directory '/var/lib' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
  directory File.join('/var/lib', app_name) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
  directory File.join('/var/lib', app_name, dad_env) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
when 'development'
  directory '/data' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
  directory File.join('/data', app_name) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
when 'test'
  directory File.join('/tmp', app_name) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
  directory File.join('/tmp', app_name, dad_env) do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
end
