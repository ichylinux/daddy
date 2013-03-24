# coding: UTF-8

前提(/^rails new careerlife -d mysql --skip-bundle$/) do
  `rm -Rf /tmp/careerlife`
  `cd /tmp && rails new careerlife -d mysql --skip-bundle`
  puts "<pre>#{`cd /tmp/careerlife && tree .`}</pre>"
end

前提(/^Gemfile に以下の gem を定義$/) do |table|
  diff('Gemfile', '/tmp/careerlife/Gemfile')
end

前提(/^sudo bundle install$/) do
  `cd /tmp/careerlife && sudo bundle install`
  diff('Gemfile.lock', '/tmp/careerlife/Gemfile.lock')
end

前提(/^rake dad:db:config$/) do
  diff('config/database.yml', '/tmp/careerlife/config/database.yml')
end

前提(/^rake dad:db:create$/) do
end

前提(/^rake db:migrate$/) do
  show 'db/schema.rb'
end

前提(/^rails s$/) do
end

前提(/^ブラウザで http:\/\/localhost:3000 にアクセス$/) do
  assert_visit '/'
end
