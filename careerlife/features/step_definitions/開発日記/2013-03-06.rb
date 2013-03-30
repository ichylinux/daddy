# coding: UTF-8

もし /^rails g controller top$/ do
  git_diff_name 'app/assets', 'app/controllers', 'test'
end

もし /^indexページを作成$/ do
  git_diff 'app/views/top/index.html.erb'
end

もし /^root の指定を変更$/ do
  git_diff 'config/routes.rb'
end

もし(/^rm public\/index\.html$/) do
end
