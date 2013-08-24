# coding: UTF-8

前提 /^レイアウトにヘッダを挿入$/ do
  git_diff 'app/views/layouts/application.html.erb'
end

前提 /^ヘッダを作成$/ do
  show 'app/views/common/_header.html.erb', :as => 'new'
end

前提 /^rails g model career_detail$/ do
  show 'db/migrate/20130308174601_create_career_details.rb', :as => ['auto', 'edit']
end

前提 /^rake db:migrate$/ do
  git_diff 'db/schema.rb', :as => 'auto', :from => 14, :to => 27
end

前提 /^view を修正$/ do
  git_diff 'app/views/careers/_form.html.erb'
  show 'app/views/careers/_career_detail_fields.html.erb', :as => 'new'
end

前提 /^controller を修正$/ do
  git_diff 'app/controllers/careers_controller.rb', :from => 26, :to => 43
end
