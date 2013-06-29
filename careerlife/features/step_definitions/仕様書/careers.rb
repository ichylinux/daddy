# coding: UTF-8

前提 /^(.*?) はキャリアを登録している$/ do |email|
  @user = User.where(:email => email).first!
  assert_not_nil @user.career
end

前提 /^(.*?) はまだキャリアを登録していない$/ do |email|
  @user = User.where(:email => email).first!
  assert_nil @user.career
end

前提 /^キャリアを表示している?$/ do
  assert_visit '/careers'
end

前提 /^キャリアの参照に遷移$/ do
  assert_url '/careers/[0-9]+'
end

前提 /^キャリアの一覧に遷移$/ do
  assert_url '/careers'
end

前提 /^キャリアの一覧を表示している$/ do
  assert_visit '/careers'
end

ならば /^キャリアの追加に遷移$/ do
  assert_url '/careers/new'
end

前提 /^キャリアの編集に遷移$/ do
  assert_url '/careers/[0-9]+/edit'
end

前提 /^キャリアの参照を表示(している|する)$/ do |suffix|
  @career = Career.all.first
  assert_visit "/careers/#{@career.id}"
end

もし /^経歴を追加 を (.*?) 回クリック$/ do |count|
  count.to_i.times do
    click_on '経歴を追加'
  end
end

ならば /^経歴の入力欄が (.*?) つ表示される$/ do |count|
  capture
  
  tr_count = count.to_i + 2
  assert_equal tr_count, find('table').all('tr').size
end

もし /^経歴に以下の内容を入力する$/ do |ast_table|
  table = normalize_table(ast_table)[1..-1]
  
  find('table').all('tr')[1..-2].each_with_index do |tr, i|
    tr.all('td')[0].find('input').set(table[i][0])
    tr.all('td')[1].find('input').set(table[i][1])
    tr.all('td')[2].find('input').set(table[i][2])
  end
  
  capture
end

もし /^プロジェクト名 を空白にする$/ do
  find('table').all('tr')[1..-2].each_with_index do |tr, i|
    tr.all('td')[0].find('input').set('')
  end
  
  capture
end

もし /^キャリア一覧の (.*?) の (.*?) をクリック$/ do |name, action|
  find_tr '.careers', name do
    click_on action
    confirm if action == '削除'
  end
end

ならば /^キャリアが削除され、一覧に遷移$/ do
  assert_url '/careers$'
end

前提 /^必須チェックエラーでキャリアを(登録|更新)できない$/ do |action|
  if action == '登録'
    assert_url '/careers$'
  elsif action == '更新'
    assert_url '/careers/[0-9]+'
  else
    pending "不明なアクション #{action}"
  end
end

前提 /^キャリアの検索結果に男性だけが表示される$/ do
  capture
  assert find('#careers_table').text.include?('男性')
end

もし /^削除 をクリックし、確認ダイアログで OK をクリック$/ do
  click_on '削除'
  confirm true
end
