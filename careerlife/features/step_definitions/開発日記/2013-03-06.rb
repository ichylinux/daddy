# coding: UTF-8

もし /^rails g controller top$/ do
  git_diff_name 'app', 'test'
end

もし /^アクション「index」を実装$/ do
  git_diff 'app/controllers/top_controller.rb'
  git_diff 'app/views/top/index.html.erb'
end

もし /^root の指定を変更$/ do
  git_diff 'config/routes.rb'
end

もし(/^rm public\/index\.html$/) do
end
