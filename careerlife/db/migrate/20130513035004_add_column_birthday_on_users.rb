class AddColumnBirthdayOnUsers < ActiveRecord::Migration
  def up
    add_column :users, :birthday, :date
  end

  def down
    remove_column :users, :birthday
  end
end
