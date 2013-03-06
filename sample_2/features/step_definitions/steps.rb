# coding: UTF-8

もし /^rails g コマンドでコントローラを作成します。$/ do
  puts 'rails g controller top'
end

ならば /^コントローラクラス、ヘルパークラス、テストクラスが生成されます。$/ do
  html = '<pre>'
  html << `diff -r -x config -x features -x tmp -x Gemfile -x Gemfile.lock features/data/careerlife .`
  html << '</pre>'
  puts html
end

もし(/^root の指定を変更します。$/) do
  pending # express the regexp above with the code you wish you had
end

もし(/^index\.html を削除します。$/) do
  pending # express the regexp above with the code you wish you had
end

ならば(/^トップ画面が表示されます。$/) do
  pending # express the regexp above with the code you wish you had
end
