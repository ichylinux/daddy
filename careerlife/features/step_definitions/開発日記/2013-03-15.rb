# coding: UTF-8

前提 /^rails g devise:install$/ do
  show 'config/initializers/devise.rb'
  show 'config/locales/devise.en.yml'
end

前提(/^development\.rb を編集$/) do
  git_diff 'config/environments/development.rb', 'careerlife/config/environments/development.rb'
end

前提(/^rails g devise user$/) do
  show 'app/models/user.rb'
  show 'db/migrate/20130314152358_devise_create_users.rb'
end

前提(/^rake db:migrate$/) do
  git_diff 'db/schema.rb', 'careerlife/db/schema.rb'
end

前提 /^devise 用の日本語ファイルを取得$/ do
  puts "<pre>wget https://gist.github.com/kawamoto/4729292/raw/ec2b3e23be61b4b8f6903efedff359fd0a4b3223/devise.ja.yml -O config/locales/devise.ja.yml</pre>"
  show 'config/locales/devise.ja.yml'
end

前提(/^コントローラを修正$/) do
  git_diff 'app/controllers/careers_controller.rb', 'careerlife/app/controllers/careers_controller.rb'
end

前提(/^ヘッダを修正/) do
  git_diff 'app/views/common/_header.html.erb', 'careerlife/app/views/common/_header.html.erb'
end

前提(/^rails g devise:views$/) do
  git = Daddy::Git.new
  branch = git.previous_branch
  puts "<pre>#{`git diff origin/#{branch} --name-only app/views`}</pre>"
end
