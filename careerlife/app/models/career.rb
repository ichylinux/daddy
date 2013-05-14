# coding: UTF-8

class Career < ActiveRecord::Base
  acts_as_like

  belongs_to :user
  has_many :career_details
  accepts_nested_attributes_for :career_details, :allow_destroy => true

  def self.search(condition)
    ret = ret.join(:user)
    ret = ret.order('users.last_name, users.first_name')
    ret = ret.like(['users.last_name', 'users.first_name'], condition.keyword) if condition.keyword.present?
    ret = ret.where('users.gender = ?', condition.gender) if condition.gender.present?
    ret
  end

end
