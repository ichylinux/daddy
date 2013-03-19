# coding: UTF-8

前提 /^日本語ロケールを用意$/ do
  file = 'config/locales/ja.yml'
  puts file
  puts "<pre>#{File.read(file)}</pre>"

  file = 'config/locales/messages.ja.yml'
  puts file
  puts "<pre>#{File.read(file)}</pre>"
end

前提 /^erb を修正$/ do
  git_diff 'app/views/careers/index.html.erb', 'careerlife/app/views/careers/index.html.erb'
end
