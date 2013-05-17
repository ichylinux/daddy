class DeleteCareers < ActiveRecord::Migration
  def up
    Career.update_all(['deleted = ?', true])
  end

  def down
  end
end
