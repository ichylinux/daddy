# coding: UTF-8

もし /^rails g コマンドでコントローラを作成します。$/ do
  puts 'rails g controller top'
end

ならば /^コントローラクラス、ヘルパークラス、テストクラスが生成されます。$/ do
  html = '<pre>'
  html << `diff -r -x config -x features -x tmp -x Gemfile -x Gemfile.lock ../sample_#{ENV['PHASE_NO'].to_i - 1}/tmp/careerlife .`
  html << '</pre>'
  puts html
end

もし(/^root の指定を変更します。$/) do
end

もし(/^index\.html を削除します。$/) do
end

ならば(/^トップ画面が表示されます。$/) do
end

もし(/^ドキュメントルートを表示します。$/) do
  assert_visit '/'
end