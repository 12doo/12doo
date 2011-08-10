# -*- encoding : utf-8 -*-
class Delivery < ActiveRecord::Base
  belongs_to :user
  has_one :product
  paginates_per 20
end
