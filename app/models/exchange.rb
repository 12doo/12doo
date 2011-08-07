# -*- encoding : utf-8 -*-
class Exchange < ActiveRecord::Base
  has_many :tickets
  paginates_per 20
  
  validates_presence_of :fullname, :no,  :count, :province, :city,  :region, :zip, :phone, :count
  validates_numericality_of :count
  validates_uniqueness_of :no
  
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
