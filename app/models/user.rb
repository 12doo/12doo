class User < ActiveRecord::Base
  
  after_create :send_welcome_email
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone, :name, :birth, :gender
  
  has_many :addresses, :foreign_key => "user_id", :primary_key => "id"
  has_many :orders, :foreign_key => "user_id", :primary_key => "id"
  has_many :coupons, :foreign_key => "user_id", :primary_key => "id"
  has_many :coupon_used_records, :foreign_key => "user_id", :primary_key => "id"
  
  # verify
  validates_uniqueness_of :phone, :allow_nil => true, :allow_blank => true
  
  def send_welcome_email
    Thread.start do 
      UserMailer.welcome_email(self).deliver
    end
  end
  
  def display_name
    self.name ? self.name : self.email
  end
  
protected
  def password_required?
    new_record?
  end
end
