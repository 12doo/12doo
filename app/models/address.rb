class Address < ActiveRecord::Base
  belongs_to :user, :foreign_key => "id", :primary_key => "user_id"
  validates_presence_of :detail, :province, :city, :region, :zip, :phone, :name
  
  def set_as_default
    self.default = true
    user = User.find(self.user_id)
    user.addresses do |address|
      address.default = false
      address.save
    end
    self.save
  end
  
end
