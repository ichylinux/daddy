# coding: UTF-8

前提(/^トップページを表示$/) do
  assert_visit '/'
end

前提(/^キャリアを表示$/) do
  assert_visit '/careers'
end

前提(/^キャリアの追加に遷移$/) do
  assert_url '/careers/new'
end

前提(/^キャリアの編集に遷移$/) do
  assert_url '/careers/[0-9]+/edit'
end

前提(/^キャリアの参照に遷移$/) do
  assert_url '/careers/[0-9]+'
end

前提(/^キャリアの一覧に遷移$/) do
  assert_url '/careers'
end

前提 /^削除 をクリック$/ do
  click_on '削除'
  confirm
end