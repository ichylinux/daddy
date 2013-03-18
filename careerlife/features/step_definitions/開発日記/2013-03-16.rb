# coding: UTF-8

前提 /^index.html.erb を修正$/ do
  git_diff('app/views/top/index.html.erb', 'careerlife/app/views/top/index.html.erb')
end

前提 /^削除リンクを追加$/ do
  git_diff('app/views/careers/index.html.erb', 'careerlife/app/views/careers/index.html.erb')
end
