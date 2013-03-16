# coding: UTF-8

require 'differ'
Differ.format = :html

前提(/^rails new careerlife -d mysql$/) do
  `rm -Rf /tmp/careerlife`
  `cd /tmp && rails new careerlife -d mysql`
  puts "<pre>#{`cd /tmp/careerlife && tree .`}</pre>"
end

前提(/^Gemfile に以下の gem を定義$/) do |table|
  a = File.read('Gemfile')
  b = File.read('/tmp/careerlife/Gemfile')
  puts "<pre>#{Differ.diff(a, b)}</pre>"
end

前提(/^sudo bundle install$/) do
  `cd /tmp/careerlife && sudo bundle install`

  a = File.read('Gemfile.lock')
  b = File.read('/tmp/careerlife/Gemfile.lock')
  puts "<pre>#{Differ.diff(a, b)}</pre>"
end

前提(/^rake dad:db:config$/) do
  a = File.read('config/database.yml')
  b = File.read('/tmp/careerlife/config/database.yml')
  puts "<pre>#{Differ.diff(a, b)}</pre>"
end

前提(/^rails s$/) do
end

前提(/^ブラウザ http:\/\/localhost:3000 にアクセス$/) do
end
