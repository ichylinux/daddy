# coding: UTF-8

前提 /^Gemfileを編集$/ do
  git_diff 'Gemfile', :from => 20, :to => 23
end

前提 /^sudo bundle install$/ do
  git_diff 'Gemfile.lock', :as => 'auto'
end

前提 /^rails g devise:install$/ do
  show 'config/initializers/devise.rb', :as => 'auto'
  show 'config/locales/devise.en.yml', :as => 'auto'
end

前提 /^development\.rb を編集$/ do
  git_diff 'config/environments/development.rb', :from => 17, :to => 18
end

前提 /^rails g devise user$/ do
  show 'app/models/user.rb', :as => 'auto'
  show 'db/migrate/20130314152358_devise_create_users.rb', :as => 'auto'
end

前提 /^rake db:migrate$/ do
  git_diff 'db/schema.rb', :as => 'auto'
end

前提 /^devise用の日本語ファイルを取得$/ do
  puts "<pre>wget https://gist.github.com/kawamoto/4729292/raw/ec2b3e23be61b4b8f6903efedff359fd0a4b3223/devise.ja.yml -O config/locales/devise.ja.yml</pre>"
  show 'config/locales/devise.ja.yml'
end

前提 /^コントローラを修正$/ do
  git_diff 'app/controllers/careers_controller.rb', :from => 1, :to => 3
end

前提 /^ヘッダを修正/ do
  git_diff 'app/views/common/_header.html.erb'
end

前提 /^rails g devise:views$/ do
  git_diff_name 'app/views/devise'
end
