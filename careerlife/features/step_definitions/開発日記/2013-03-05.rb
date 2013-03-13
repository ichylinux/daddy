# coding: UTF-8

前提(/^rails new careerlife \-d mysql$/) do
  `rm -Rf /tmp/careerlife`
  puts "<pre>#{`cd /tmp && rails new careerlife -d mysql`}</pre>"
end

前提(/^Gemfile に以下の gem を定義$/) do |table|
  puts "<pre>#{`diff Gemfile /tmp/careerlife/Gemfile`}</pre>"
end

前提(/^sudo bundle install$/) do
  puts "<pre>#{`cd /tmp/careerlife && sudo bundle install`}</pre>"
  puts "<pre>#{`diff Gemfile.lock /tmp/careerlife/Gemfile.lock`}</pre>"
end

前提(/^rake dad:db:config$/) do
  puts "<pre>#{`cd /tmp/careerlife && rake dad:db:config`}</pre>"
  puts "<pre>#{File.read('config/database.yml')}</pre>"
end

前提(/^rails s$/) do
end

前提(/^ブラウザ http:\/\/localhost:3000 にアクセス$/) do
end
