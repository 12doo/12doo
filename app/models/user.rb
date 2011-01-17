class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :addresses, :foreign_key => "user_id", :primary_key => "id"
  has_many :orders, :foreign_key => "user_id", :primary_key => "id"
  
  # verify
  validates_uniqueness_of :email, :phone
  validates_presence_of :email
end
