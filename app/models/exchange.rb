class Exchange < ActiveRecord::Base
  has_many :tickets
  
  def set_address(address)
    self.fullname = address.name
    self.address = address.detail
    self.province = address.province
    self.city = address.city
    self.region = address.region
    self.zip = address.zip
    self.phone = address.phone
  end
  
end
