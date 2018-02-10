require 'daddy/itamae'

template '/etc/yum.repos.d/google.chrome.repo' do
  user 'root'
end

package 'google-chrome-stable' do
  user 'root'
end
