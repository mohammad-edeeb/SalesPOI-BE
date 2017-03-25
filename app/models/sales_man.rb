class SalesMan < ApplicationRecord

  validates_presence_of :username, :password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, recoverable, :rememberable, :trackable, :registerable
  devise :database_authenticatable, :validatable

  has_secure_token :auth_token

  def email_required?
  	false
  end

  def email_changed?
  	false
  end

  class << self
  	def permitted_attrs
  		[:username, :password, :password_confirmation]
  	end
  end
end
