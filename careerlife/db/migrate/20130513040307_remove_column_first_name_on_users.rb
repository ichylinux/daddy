class RemoveColumnFirstNameOnUsers < ActiveRecord::Migration
  def up
    remove_column :careers, :first_name
  end

  def down
    add_column :careers, :first_name, :string
  end
end
