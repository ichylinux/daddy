# coding: UTF-8

前提 /^ヘッダを修正$/ do
  git_diff 'app/views/common/_header.html.erb'
  assert_visit '/'
end
