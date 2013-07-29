# coding: UTF-8

class User < ActiveRecord::Base
  include UserConst

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :last_name, :first_name, :gender, :birthday

  validates :last_name, :presence => true, :on => :update
  validates :first_name, :presence => true, :on => :update

  has_one :career

  def full_name
    self.last_name.to_s + self.first_name.to_s
  end

  def gender_name
    GENDERS[self.gender]
  end

  def age
    return nil unless self.birthday
    
    now = Time.now.utc.to_date
    now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end
end
