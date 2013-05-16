# coding: UTF-8

前提 /^トップページを表示(している|する)$/ do |suffix|
  assert_visit '/'
end

前提 /^トップページに遷移$/ do
  assert_url '^/$'
end

