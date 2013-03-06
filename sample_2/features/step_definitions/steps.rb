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
