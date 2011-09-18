# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone, :name, :birth, :gender
  
  has_many :addresses
  has_many :orders
  has_many :coupons
  has_many :coupon_used_records
  has_many :order_items
  has_many :favorites
  
  paginates_per 20
  
  # verify
  validates_uniqueness_of :phone, :allow_nil => true, :allow_blank => true
  
  def display_name
    self.name ? self.name : self.email
  end
  
  def set_role(role)
    case role
      when "admin"
        self.update_attribute :admin, true
      when "user"
        self.update_attribute :admin, false
    end
    
  end
  
  protected
  def password_required?
    new_record?
  end
end
