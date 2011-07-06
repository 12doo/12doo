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
    pro = product
    temp.product_name = pro.cn_name
    temp.product_sku = pro.sku
    temp.price = pro.price
    temp.product_id = pro.id
    if pro.promo_price > 0
      temp.price = pro.promo_price
    end
    
    temp.quantity = self.quantity
    temp.subtotal = self.subtotal
    
    temp
  end
  
  def product
    Product.find(productid)
  end
  
  def subtotal
    pro = self.product
    (pro.price * @quantity).to_f
    if pro.promo_price > 0
      (pro.promo_price * @quantity).to_f
    end
  end 
end
