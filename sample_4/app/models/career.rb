# coding: UTF-8

class Career < ActiveRecord::Base
  attr_accessible :birthday, :first_name, :gender, :last_name
  
  def full_name
    self.last_name.to_s + self.first_name.to_s
  end
  
  def gender_name
    case self.gender.upcase
    when 'M'
      '男性'
    when 'F'
      '女性'
    end
  end
end
