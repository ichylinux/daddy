class AddColumnFirstNameOnCareers < ActiveRecord::Migration
  def up
    add_column :careers, :first_name, :string
  end

  def down
    remove_column :careers, :first_name
  end
end
