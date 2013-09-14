# coding: UTF-8

もし /^キャリア明細から年数を計算$/ do
  git_diff 'app/models/career.rb', :from => 17, :to => 48
end

もし /^トップページに表示$/ do
  git_diff 'app/views/top/index.html.erb', :from => 6, :to => 22
  git_diff 'config/locales/ja.yml', :from => 8, :to => 11
end
