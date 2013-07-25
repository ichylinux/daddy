# coding: UTF-8

class Career < ActiveRecord::Base
  belongs_to :user
  has_many :career_details
  accepts_nested_attributes_for :career_details, :allow_destroy => true

  def self.search(condition)
    ret = where(:deleted => false)
    ret = ret.joins(:user)
    ret = ret.where('users.gender = ?', condition.gender) if condition.gender.present?
    ret = ret.like(['users.last_name', 'users.first_name'], condition.keyword) if condition.keyword.present?
    ret = ret.order('users.last_name, users.first_name')
    ret
  end

end
