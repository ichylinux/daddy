class Career < ActiveRecord::Base
  attr_accessible :birthday, :first_name, :gender, :last_name
  
  def full_name
    self.last_name.to_s + self.first_name.to_s
  end
end
