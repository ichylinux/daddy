もし /^(.*?) を選択(する)?$/ do |name, suffix|
  click_on name
end

もし /^(.*?) にチェック(を入れる)?$/ do |name, suffix|
  assert_check name
end

もし /^(.*?) に (.*?) を選ぶ?$/ do |name, value|
  assert_choose value
end

もし /^(.*?) を空白にする$/ do |name|
  assert_fill_in name, ''
end
