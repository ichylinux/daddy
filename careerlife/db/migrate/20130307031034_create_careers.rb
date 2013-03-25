class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :last_name
      t.string :first_name
      t.date :birthday
      t.string :gender

      t.timestamps
    end
  end
end
