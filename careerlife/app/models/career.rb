# coding: UTF-8

class Career < ActiveRecord::Base

  has_many :career_details
  accepts_nested_attributes_for :career_details, :allow_destroy => true

  validates :last_name, :presence => true
  validates :first_name, :presence => true

  def full_name
    self.last_name.to_s + self.first_name.to_s
  end

  def gender_name
    return nil unless self.gender

    case self.gender.upcase
    when 'M'
      '男性'
    when 'F'
      '女性'
    end
  end
end
