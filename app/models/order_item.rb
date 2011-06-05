# -*- encoding : utf-8 -*-
class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  
  def product
    Product.find_by_sku(product_sku)
  end
end
