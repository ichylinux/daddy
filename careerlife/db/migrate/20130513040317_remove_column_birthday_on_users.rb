class RemoveColumnBirthdayOnUsers < ActiveRecord::Migration
  def up
    remove_column :careers, :birthday
  end

  def down
    add_column :careers, :birthday, :date
  end
end
