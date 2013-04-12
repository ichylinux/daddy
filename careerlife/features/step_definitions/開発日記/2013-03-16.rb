# coding: UTF-8

前提 /^コントローラを修正$/ do
  git_diff 'app/controllers/top_controller.rb'
end

前提 /^ビューを修正$/ do
  git_diff 'app/views/top/index.html.erb'
end

