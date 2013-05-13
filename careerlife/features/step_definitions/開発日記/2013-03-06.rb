# coding: UTF-8

前提 /^rails g scaffold career last_name:string first_name:string birthday:date gender:string$/ do
  git_diff_name 'app', 'db', 'test'
end

前提 /^rake db:migrate$/ do
  git_diff 'db/schema.rb', :as => 'auto'
end

