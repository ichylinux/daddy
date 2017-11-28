directory '/opt/nginx-rtmp-module' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end

git '/opt/nginx-rtmp-module/v1.1.11' do
  repository 'https://github.com/arut/nginx-rtmp-module.git'
  revision 'v1.1.11'
end
