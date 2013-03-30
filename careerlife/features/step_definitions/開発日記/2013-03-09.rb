# coding: UTF-8

前提 /^レイアウトにヘッダを挿入$/ do
  git_diff 'app/views/layouts/application.html.erb'
end

前提 /^ヘッダを作成$/ do
  git_diff 'app/views/common/_header.html.erb'
end

前提 /^rails g model career_detail$/ do
  git_diff 'db/migrate/20130308174601_create_career_details.rb'
end

前提 /^rake db:migrate$/ do
  git_diff 'db/schema.rb'
end

前提 /^view を修正$/ do
  git_diff 'app/views/careers/_form.html.erb'
  git_diff 'app/views/careers/_career_detail_fields.html.erb'
end

前提 /^controller を修正$/ do
  git_diff 'app/controllers/careers_controller.rb'
end
