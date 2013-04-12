# coding: UTF-8

前提 /^姓 名 を必須に$/ do
  git_diff 'app/models/career.rb'
end

前提 /^プロジェクト名 を必須に$/ do
  git_diff 'app/models/career_detail.rb'
end
