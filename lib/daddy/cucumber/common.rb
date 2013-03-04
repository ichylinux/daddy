# coding: UTF-8

もし /^(.*?) をクリックする$/ do |name|
  click_on name
end

もし /^(.*?) を選択する$/ do |name|
  click_on name
end

もし /^(.*?) にチェックを入れる$/ do |name|
  assert_check name
end

もし /^(.*?) に (.*?) を選択する$/ do |name, value|
  assert_select name, value
end

もし /^(.*?) に (.*?) と入力する$/ do |name, value|
  assert_fill_in name, value
end

もし /^(.*?) に (.*?) とリッチに入力する$/ do |name, value|
  assert_fill_in_rich name, value
end
