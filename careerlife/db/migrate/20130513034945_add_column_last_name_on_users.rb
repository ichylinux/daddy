class AddColumnLastNameOnUsers < ActiveRecord::Migration
  def up
    add_column :users, :last_name, :string
  end

  def down
    remove_column :users, :last_name
  end
end
