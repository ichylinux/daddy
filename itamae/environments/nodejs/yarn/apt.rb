recipe_dir = ::File.dirname(::File.dirname(__FILE__))
yarn_deb_repo = ::File.join(recipe_dir, 'files/etc/apt/sources.list.d/yarn.list')
yarn_key_url = 'https://dl.yarnpkg.com/debian/pubkey.gpg'
# Yarn Packaging <yarn@dan.cx>
yarn_key_fingerprint = '72ECF46A56B4AD39C907BBB71646B01B86E50310'
yarn_keyring = '/usr/share/keyrings/yarn.gpg'

execute "place #{yarn_keyring}" do
  user 'root'
  command <<-EOF
    set -eu
    mkdir -p /usr/share/keyrings
    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT
    curl -fsSL #{yarn_key_url} -o "$tmp"
    actual=$(gpg --show-keys --with-colons --fingerprint "$tmp" | awk -F: '/^fpr:/ {print $10; exit}')
    if [ "$actual" != "#{yarn_key_fingerprint}" ]; then
      echo "unexpected yarn signing key fingerprint: $actual" >&2
      exit 1
    fi
    gpg --dearmor < "$tmp" | tee #{yarn_keyring} > /dev/null
    chmod 644 #{yarn_keyring}
  EOF
  not_if "test -s #{yarn_keyring} && gpg --show-keys --with-colons --fingerprint #{yarn_keyring} 2>/dev/null | awk -F: '/^fpr:/ {print $10; exit}' | grep -qx #{yarn_key_fingerprint}"
end

execute 'place yarn apt repository' do
  user 'root'
  command <<-EOF
    set -eu
    mkdir -p /etc/apt/sources.list.d
    cp -f #{yarn_deb_repo} /etc/apt/sources.list.d/yarn.list
    chmod 644 /etc/apt/sources.list.d/yarn.list
  EOF
  not_if "diff #{yarn_deb_repo} /etc/apt/sources.list.d/yarn.list"
end

# Run whenever the yarn index is missing from the apt cache (e.g. the
# repository was just added or the cache was cleaned).
execute 'apt-get update (yarn)' do
  user 'root'
  command 'apt-get update'
  not_if 'apt-cache policy yarn | grep -q dl.yarnpkg.com'
end

package 'yarn' do
  user 'root'
end
