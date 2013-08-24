# coding: UTF-8

前提 /^rails g controller profiles$/ do
  show 'app/controllers/profiles_controller.rb', :as => ['auto', 'edit']
end

前提 /^routes を修正$/ do
  git_diff 'config/routes.rb', :to => 10
end

前提(/^ユーザモデルを修正$/) do
  git_diff 'app/models/user.rb'
end

前提(/^ヘッダを修正$/) do
  git_diff 'app/views/common/_header.html.erb'
end

前提(/^参照画面$/) do
  show 'app/views/profiles/show.html.erb', :as => 'new'
end

前提(/^編集画面$/) do
  show 'app/views/profiles/edit.html.erb', :as => 'new'
  show 'app/views/profiles/_form.html.erb', :as => 'new'
end
