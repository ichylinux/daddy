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

  def work_experience_months
    min = nil
    max = nil
    career_details.each do |cd|
      if min.nil?
        min = cd.start_date
      elsif cd.start_date < min
        min = cd.start_date
      end
      
      if max.nil?
        max = cd.end_date
      elsif cd.end_date and cd.end_date > max
        max = cd.end_date
      end
    end
    
    return 0 unless min
    
    max ||= Date.today
    
    ret = (max - min).to_i / 30
  end

  def work_experience
    months = work_experience_months
    if months >= 12
      "#{months/12}年#{months%12}ヶ月"
    else
      "#{months%12}ヶ月"
    end
  end

end
