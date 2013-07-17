# coding: UTF-8

もし /^(.*?)\s*をクリック(する)?$/ do |name, suffix|
  click_on name
end

もし /^(.*?) を選択(する)?$/ do |name, suffix|
  click_on name
end

もし /^(.*?) にチェック(を入れる)?$/ do |name, suffix|
  assert_check name
end

もし /^(.*?) に (.*?) を選択(する)?$/ do |name, value, suffix|
  assert_select name, value
end

もし /^(.*?) に (.*?) を選ぶ?$/ do |name, value|
  assert_choose value
end

もし /^(.*?) を空白にする$/ do |name|
  assert_fill_in name, ''
end

もし /^(.*?) に (.*?) と入力(する)?$/ do |name, value, suffix|
  assert_fill_in name, value
end

もし /^(.*?) に以下の文章を入力(する)?$/ do |name, suffix, text|
  assert_fill_in name, text
end

もし /^(.*?) に (.*?) とリッチに入力(する)?$/ do |name, value, suffix|
  assert_fill_in_rich name, value
end
