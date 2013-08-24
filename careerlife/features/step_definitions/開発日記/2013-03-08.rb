# coding: UTF-8

前提 /^日本語ロケールを用意$/ do
  show 'config/locales/ja.yml', :as => 'new'
  show 'config/locales/messages.ja.yml', :as => 'new'
end

前提 /^erb を修正$/ do
  git_diff 'app/views/careers/index.html.erb'
end

前提 /^通知メッセージを修正$/ do
  git_diff 'app/controllers/careers_controller.rb', :from => 42, :to => 82
end
