# coding: UTF-8

前提 /^プロフィールの参照に遷移$/ do
  assert_url "/profiles/#{@current_user.id}$"
end

前提 /^プロフィールの参照を表示している$/ do
  assert_visit "/profiles/#{@current_user.id}"
end

前提 /^プロフィールの編集に遷移$/ do
  assert_url "/profiles/#{@current_user.id}/edit$"
end

前提 /^プロフィールの編集を表示している$/ do
  assert_visit "/profiles/#{@current_user.id}/edit"
end

前提 /^必須チェックエラーでプロフィールを更新できない$/ do
  assert_url '/profiles/[0-9]+$'
end
