# coding: UTF-8

前提(/^キャリアを表示$/) do
  assert_visit '/careers'
end

前提(/^キャリアの参照に遷移$/) do
  assert_url '/careers/[0-9]+'
end

前提(/^キャリアの一覧に遷移$/) do
  assert_url '/careers'
end

前提(/^TOPページを表示$/) do
  assert_visit '/'
end
