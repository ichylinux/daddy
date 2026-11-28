recipe_dir = ::File.dirname(__FILE__)
nodesource_deb_repo = ::File.join(recipe_dir, 'files/etc/apt/sources.list.d/nodesource-nodejs-v26.sources')
nodejs_pin = ::File.join(recipe_dir, 'files/etc/apt/preferences.d/nodejs')
nsolid_pin = ::File.join(recipe_dir, 'files/etc/apt/preferences.d/nsolid')
nodesource_keyring = '/usr/share/keyrings/nodesource.gpg'
nodejs_version = '26.13.1-1nodesource1'

execute "place #{nodesource_keyring}" do
  user 'root'
  command <<-EOF
    set -eu
    mkdir -p /usr/share/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor | tee #{nodesource_keyring} > /dev/null
    chmod 644 #{nodesource_keyring}
  EOF
  not_if "test -s #{nodesource_keyring}"
end

execute 'place nodesource apt repository' do
  user 'root'
  command <<-EOF
    set -eu
    mkdir -p /etc/apt/sources.list.d /etc/apt/preferences.d
    cp -f #{nodesource_deb_repo} /etc/apt/sources.list.d/nodesource.sources
    chmod 644 /etc/apt/sources.list.d/nodesource.sources
    cp -f #{nodejs_pin} /etc/apt/preferences.d/nodejs
    chmod 644 /etc/apt/preferences.d/nodejs
    cp -f #{nsolid_pin} /etc/apt/preferences.d/nsolid
    chmod 644 /etc/apt/preferences.d/nsolid
  EOF
  not_if "diff #{nodesource_deb_repo} /etc/apt/sources.list.d/nodesource.sources"
end

# Run whenever the nodesource index is missing from the apt cache.
execute 'apt-get update (nodesource-nodejs)' do
  user 'root'
  command 'apt-get update'
  not_if 'apt-cache policy nodejs | grep -q deb.nodesource.com'
end

package 'nodejs' do
  user 'root'
  version nodejs_version
end
