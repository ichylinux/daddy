template '/etc/yum.repos.d/vbatts-bazel.repo' do
  user 'root'
end

package 'bazel' do
  user 'root'
end
