class User < ActiveRecord::Base
  
  after_create :send_welcome_email
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :addresses, :foreign_key => "user_id", :primary_key => "id"
  has_many :orders, :foreign_key => "user_id", :primary_key => "id"
  has_many :coupons, :foreign_key => "user_id", :primary_key => "id"
  has_many :coupon_used_records, :foreign_key => "user_id", :primary_key => "id"
  
  # verify
  validates_uniqueness_of :phone, :allow_nil => true, :allow_blank => true
  
  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end
end
