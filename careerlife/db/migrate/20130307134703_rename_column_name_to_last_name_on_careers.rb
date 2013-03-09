class RenameColumnNameToLastNameOnCareers < ActiveRecord::Migration
  def up
    rename_column :careers, :name, :last_name
  end

  def down
    rename_column :careers, :last_name, :name
  end
end
