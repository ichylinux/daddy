# coding: UTF-8

前提 /^rails g migration add_column_last_name_on_users$/ do
  show 'db/migrate/20130513034945_add_column_last_name_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration add_column_first_name_on_users$/ do
  show 'db/migrate/20130513034954_add_column_first_name_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration add_column_gender_on_users$/ do
  show 'db/migrate/20130513034959_add_column_gender_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration add_column_birthday_on_users$/ do
  show 'db/migrate/20130513035004_add_column_birthday_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration add_column_deleted_on_careers$/ do
  show 'db/migrate/20130513035957_add_column_deleted_on_careers.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration remove_column_last_name_on_careers$/ do
  show 'db/migrate/20130513040300_remove_column_last_name_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration remove_column_first_name_on_careers$/ do
  show 'db/migrate/20130513040307_remove_column_first_name_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration remove_column_gender_on_careers$/ do
  show 'db/migrate/20130513040312_remove_column_gender_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration remove_column_birthday_on_careers$/ do
  show 'db/migrate/20130513040317_remove_column_birthday_on_users.rb', :as => ['auto', 'edit']
end

前提 /^rails g migration add_column_user_id_on_careers$/ do
  show 'db/migrate/20130514031653_add_column_user_id_on_careers.rb', :as => ['auto', 'edit']
end

前提 /^rake db:migrate$/ do
  git_diff 'db/schema.rb', :as => 'auto'
end

前提 /^キャリアとユーザの紐付け$/ do
  git_diff 'app/models/career.rb'
  show 'app/models/user_const.rb', :as => 'new'
  git_diff 'app/models/user.rb'
end

前提 /^rails g migration delete_careers$/ do
  show 'db/migrate/20130517043320_delete_careers.rb', :as => ['auto', 'edit']
end
