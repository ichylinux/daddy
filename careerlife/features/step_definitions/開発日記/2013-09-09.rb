# coding: UTF-8

もし /^キャリア明細から年数を計算$/ do
  git_diff 'app/models/career.rb', :from => 17, :to => 48
end
