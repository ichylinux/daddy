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
end
