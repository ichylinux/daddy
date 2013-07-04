# coding: UTF-8

もし /^content_for で拡張の余地を設ける$/ do
  git_diff 'app/views/layouts/application.html.erb'
end