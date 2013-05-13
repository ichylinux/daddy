# coding: UTF-8

前提(/^rails new careerlife -d mysql$/) do
  `rm -Rf /tmp/careerlife`
  `cd /tmp && rails new careerlife -d mysql --skip-bundle`
  puts "<pre>#{`cd /tmp/careerlife && tree .`}</pre>"
end

前提 /^Gemfileを編集$/ do
  diff 'Gemfile', '/tmp/careerlife/Gemfile', :as => 'edit'
end

前提(/^sudo bundle install$/) do
  `cd /tmp/careerlife && sudo bundle install`
  diff 'Gemfile.lock', '/tmp/careerlife/Gemfile.lock', :as => 'auto'
end

前提 /^rake dad:unicorn:install$/ do
  show 'config/unicorn.rb', :as => 'auto'
  show '/etc/init.d/unicorn', :as => 'auto'
end

前提 /^rake dad:nginx:install$/ do
  show '/etc/nginx/conf.d/nginx.conf', :as => 'auto'
end

前提(/^rake dad:db:config$/) do
  diff 'config/database.yml', '/tmp/careerlife/config/database.yml', :as => 'auto'
end

前提(/^rake dad:db:create$/) do
end

前提(/^rake db:migrate$/) do
  show 'db/schema.rb', :as => 'auto'
end

前提 /^rake dad:install$/ do
  show 'features/support/env.rb', :as => 'auto'
end

前提 /^sudo service nginx start$/ do
end

前提(/^sudo service unicorn start$/) do
end

前提(/^ブラウザで http:\/\/localhost にアクセス$/) do
  assert_visit '/'
end
