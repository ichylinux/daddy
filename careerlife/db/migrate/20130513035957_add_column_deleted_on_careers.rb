class AddColumnDeletedOnCareers < ActiveRecord::Migration
  def up
    add_column :careers, :deleted, :boolean, :null => false, :default => false
  end

  def down
    remove_column :careers, :deleted
  end
end
