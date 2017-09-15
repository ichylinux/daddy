package 'git' do
  user 'root'
end

execute 'curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash' do
  not_if 'test -e /etc/yum.repos.d/github_git-lfs.repo'
end

package 'git-lfs' do
  user 'root'
end
