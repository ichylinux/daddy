require 'daddy/itamae'

%w{
  epel-release
  certbot
  python2-certbot-nginx
}.each do |name|
  package name do
    user 'root'
  end
end
