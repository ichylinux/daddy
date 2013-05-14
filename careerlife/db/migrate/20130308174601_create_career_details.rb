class CreateCareerDetails < ActiveRecord::Migration
  def change
    create_table :career_details do |t|
      t.integer :career_id, :null => false
      t.string :project_name, :null => false
      t.date :start_date, :null => false
      t.date :end_date
      t.timestamps
    end
  end
end
