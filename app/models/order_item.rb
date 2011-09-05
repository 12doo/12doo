# -*- encoding : utf-8 -*-
class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :product
  
  cattr_reader :per_page
  paginates_per 20
end
