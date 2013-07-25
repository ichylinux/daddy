# coding: UTF-8

class Career < ActiveRecord::Base
  include CareerConst

  has_many :career_details
  accepts_nested_attributes_for :career_details, :allow_destroy => true

  validates :last_name, :presence => true
  validates :first_name, :presence => true

  def self.search(condition)
    ret = order('last_name, first_name')
    ret = ret.like([:last_name, :first_name], condition.keyword) if condition.keyword.present?
    ret = ret.where(:gender => condition.gender) if condition.gender.present?
    ret
  end

  def full_name
    self.last_name.to_s + self.first_name.to_s
  end

  def gender_name
    GENDERS[self.gender]
  end
end
