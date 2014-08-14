もし /^(.*?)に(.*?)を選択$/ do |name, value|
  assert_select name, value
end

もし /^(.*?)に (.*?) を選択$/ do |name, value|
  assert_select name, value
end

もし /^(.*?) に (.*?) を選択$/ do |name, value|
  assert_select name, value
end

もし /^(.*?)に(.*?)を選択する$/ do |name, value|
  assert_select name, value
end

もし /^(.*?)に (.*?) を選択する$/ do |name, value|
  assert_select name, value
end

もし /^(.*?) に (.*?) を選択する$/ do |name, value|
  assert_select name, value
end
