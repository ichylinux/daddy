class AddColumnGenderOnUsers < ActiveRecord::Migration
  def up
    add_column :users, :gender, :string, :limit => 1
  end

  def down
    remove_column :users, :gender
  end
end
