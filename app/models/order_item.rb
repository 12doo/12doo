# -*- encoding : utf-8 -*-
class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  
  cattr_reader :per_page
  paginates_per 20
  
  def product
    Product.find_by_sku(product_sku)
  end
end
