# coding: UTF-8

もし /^rails g controller top$/ do
  puts "<pre>#{`git diff origin/p1 --name-only app test`}</pre>"
end

もし(/^アクション「index」を実装$/) do
  git_diff 'app/controllers/top_controller.rb', 'careerlife/app/controllers/top_controller.rb'
  git_diff 'app/views/top/index.html.erb', 'careerlife/app/views/top/index.html.erb'
end

もし(/^root の指定を変更$/) do
  git_diff 'config/routes.rb', 'careerlife/config/routes.rb'
end

もし(/^rm public\/index\.html$/) do
end
