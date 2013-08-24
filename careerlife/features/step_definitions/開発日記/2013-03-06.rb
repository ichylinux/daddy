# coding: UTF-8

もし /^rails g controller top$/ do
  git_diff_name 'app/assets', 'app/controllers', 'test'
end

もし /^indexページを作成$/ do
  show 'app/views/top/index.html.erb', :as => 'new'
end

もし /^root の指定を変更$/ do
  git_diff 'config/routes.rb', :as => 'edit', :from => 49, :to => 51
end

もし /^rm public\/index\.html$/ do
end

もし /^ブラウザで http:\/\/localhost にアクセス$/ do
  assert_visit '/'
end
