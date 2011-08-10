# -*- encoding : utf-8 -*-
class Address < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :detail, :province, :city, :region, :zip, :phone, :name
  paginates_per 20
  
  def set_as_default
    user = User.find(self.user_id)
    user.addresses.each do |address|
      address.default = false
      address.save
    end
    self.default = true
    self.save
  end
  
end
