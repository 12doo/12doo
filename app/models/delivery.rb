# -*- encoding : utf-8 -*-
class Delivery < ActiveRecord::Base
  belongs_to :user
  has_one :product
end
