require 'daddy/itamae'

%w{ git }.each do |name|
  package name do
    user 'root'
  end
end

directory '/opt/letsencrypt' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end

git '/opt/letsencrypt/certbot' do
  repository 'https://github.com/certbot/certbot'
end