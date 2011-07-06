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
  
  def get_order_item
    temp = OrderItem.new
    temp.product_name = self.product.cn_name
    temp.product_sku = self.product.sku
    temp.price = self.product.price
    temp.quantity = self.quantity
    temp.subtotal = self.subtotal
    temp
  end
  
  def product
    Product.find(productid)
  end
  
  def subtotal
    (product.price * @quantity).to_f
  end 
end
