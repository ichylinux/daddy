# coding: UTF-8

前提 /^レイアウトにヘッダを挿入$/ do
  git_diff 'app/views/layouts/application.html.erb', 'careerlife/app/views/layouts/application.html.erb'
end

前提 /^ヘッダを作成$/ do
  file = 'app/views/common/_header.html.erb'
  puts file
  puts "<pre>#{File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')}</pre>"
end

前提 /^rails g model career_detail$/ do
  file = 'db/migrate/20130308174601_create_career_details.rb'
  puts file
  puts "<pre>#{File.read(file)}</pre>"
end

前提 /^view を修正$/ do
  git_diff 'app/views/careers/_form.html.erb', 'careerlife/app/views/careers/_form.html.erb'

  file = 'app/views/careers/_career_detail_fields.html.erb'
  puts file
  puts "<pre>#{File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')}</pre>"
end

前提 /^controller を修正$/ do
  git_diff 'app/controllers/careers_controller.rb', 'careerlife/app/controllers/careers_controller.rb'
end
