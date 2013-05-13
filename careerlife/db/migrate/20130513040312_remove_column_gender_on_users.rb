class RemoveColumnGenderOnUsers < ActiveRecord::Migration
  def up
    remove_column :careers, :gender
  end

  def down
    add_column :careers, :gender, :string
  end
end
