# coding: UTF-8

もし /^content_for で拡張の余地を設ける$/ do
  git_diff 'app/views/layouts/application.html.erb'
end

もし /^プロフィール機能とキャリア機能をサイドバー付きのレイアウトに変更$/ do
  git_diff 'app/views/layouts/profiles.html.erb', :as => 'new'
  git_diff 'app/controllers/careers_controller.rb'
end
