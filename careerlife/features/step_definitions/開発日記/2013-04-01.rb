# coding: UTF-8

前提 /^ヘッダを修正$/ do
  git_diff 'app/views/common/_header.html.erb'
  assert_visit '/'
end

もし /^ヘルパーメソッドを読み込む$/ do
  git_diff 'app/helpers/application_helper.rb'
end

もし /^改行して表示$/ do
  git_diff 'app/views/careers/show.html.erb', :from => 23, :to => 32
  
  user = User.all.first
  step "#{user.email} がログインしている"
  step "キャリアの参照を表示する"
end
