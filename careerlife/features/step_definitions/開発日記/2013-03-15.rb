# coding: UTF-8

前提(/^rails g devise:install$/) do
end

前提(/^development\.rb を編集$/) do |string|
end

前提(/^rails g devise user$/) do
end

前提(/^rake db:migrate$/) do
end

前提 /^devise 用の日本語ファイルを取得$/ do
  puts "<pre>wget https://gist.github.com/kawamoto/4729292/raw/ec2b3e23be61b4b8f6903efedff359fd0a4b3223/devise.ja.yml -O config/locales/devise.ja.yml</pre>"
end

前提(/^before_filter :authenticate_user!$/) do
end

前提(/^ログアウトを用意$/) do
end

前提(/^rails g devise:views$/) do
end
