# coding: UTF-8

前提 /^検索条件モデルを作成$/ do
  show 'app/models/career_condition.rb', :as => 'new'
end

前提 /^検索メソッドを作成$/ do
  show 'app/models/career_const.rb', :as => 'new'
  git_diff 'app/models/career.rb'
end

前提 /^検索フォームを作成$/ do
  show 'app/views/top/_search.html.erb', :as => 'new'
  git_diff 'app/views/top/index.html.erb'
  git_diff 'app/controllers/top_controller.rb'
end
