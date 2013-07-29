# coding: UTF-8

前提 /^生年月日から年齢を算出するメソッドを作成$/ do
  git_diff 'app/models/user.rb'
end

前提 /^トップページの一覧を修正$/ do
  git_diff 'app/views/top/index.html.erb'
end
