# coding: UTF-8

もし /^(.*?)に (.*?) と入力$/ do |name, value|
  assert_fill_in name, value
end

もし /^(.*?) に (.*?) と入力$/ do |name, value|
  assert_fill_in name, value
end

もし /^(.*?)に (.*?) と入力する$/ do |name, value|
  assert_fill_in name, value
end

もし /^(.*?) に (.*?) と入力する$/ do |name, value|
  assert_fill_in name, value
end

もし /^(.*?) に以下の文章を入力$/ do |name, text|
  assert_fill_in name, text
end

もし /^(.*?) に以下の文章を入力する$/ do |name, text|
  assert_fill_in name, text
end
