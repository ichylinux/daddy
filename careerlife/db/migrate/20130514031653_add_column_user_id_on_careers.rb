class AddColumnUserIdOnCareers < ActiveRecord::Migration
  def up
    add_column :careers, :user_id, :integer
  end

  def down
    remove_column :careers, :user_id
  end
end
