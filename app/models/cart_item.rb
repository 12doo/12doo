# -*- encoding : utf-8 -*-
class CartItem
  attr_reader :productid, :quantity
  
  def initialize(productid,quantity = 1) 
    @productid = productid
    @quantity = quantity
  end
  
  def update_quantity(quantity = 1)
    @quantity = quantity
  end
  
  def name
    product.name
  end
  
  def product
    Product.find(productid)
  end
  
  def subtotal
    (product.price * @quantity).to_f
  end 
end
