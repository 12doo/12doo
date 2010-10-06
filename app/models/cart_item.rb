class CartItem
  attr_reader :product, :quantity
  
  def initialize(product,quantity = 1) 
    @product = product
    @quantity = quantity
  end
  
  def update_quantity(quantity = 1)
    @quantity = quantity
  end
  
  def name
    @product.name
  end
  
  def subtotal
    (@product.price * @quantity).to_f
  end 
end