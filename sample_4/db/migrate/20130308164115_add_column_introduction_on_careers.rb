class AddColumnIntroductionOnCareers < ActiveRecord::Migration
  def up
    add_column :careers, :introduction, :string, :limit => 1023
  end

  def down
    remove_column :careers, :introduction
  end
end
