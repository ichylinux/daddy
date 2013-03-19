# coding: UTF-8

前提 /^rails g migration add_column_introduction_on_careers$/ do
  file = File.read('db/migrate/20130308164115_add_column_introduction_on_careers.rb')
  puts "<pre>#{file}</pre>"
end
