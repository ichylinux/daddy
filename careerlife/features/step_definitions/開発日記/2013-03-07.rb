# coding: UTF-8

前提 /^rails g migration add_column_introduction_on_careers$/ do
  git_diff 'db/migrate/20130308164115_add_column_introduction_on_careers.rb'
end

前提 /^rake db:migrate$/ do
  git_diff 'db/schema.rb'
end
