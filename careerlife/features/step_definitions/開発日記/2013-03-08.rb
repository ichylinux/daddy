# coding: UTF-8

前提 /^日本語ロケールを用意$/ do
  show 'config/locales/ja.yml'
  show 'config/locales/messages.ja.yml'
end

前提 /^erb を修正$/ do
  git_diff 'app/views/careers/index.html.erb'
end
