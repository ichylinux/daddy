# coding: UTF-8

前提(/^rails g scaffold career name:string birthday:date gender:string$/) do
  puts "<pre>#{`git diff origin/p2 --name-only app db test`}</pre>"
end

前提(/^rake db:migrate$/) do
  puts "<pre>#{File.read('db/schema.rb')}</pre>"
end

