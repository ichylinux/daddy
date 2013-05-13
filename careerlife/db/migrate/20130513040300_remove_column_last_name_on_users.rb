class RemoveColumnLastNameOnUsers < ActiveRecord::Migration
  def up
    remove_column :careers, :last_name
  end

  def down
    add_column :careers, :last_name, :string
  end
end
