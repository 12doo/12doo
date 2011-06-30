# -*- encoding : utf-8 -*-
class Cart 
  attr_reader :items
  def initialize 
    @items = []
  end

  def add_product(product, quantity = 1)
    if quantity > 0
      current_item = @items.find {|item| item.product == product} 
      if current_item
        current_item.update_quantity(current_item.quantity + quantity)
      else
        @items << CartItem.new(product.id,quantity)
      end
    end
  end
  
  def delete_product(product)
    current_item = @items.find {|item| item.product == product} 
    if current_item
      @items.delete(current_item)
    end
  end
  
  def update_product(product,quantity = 1)
    if quantity > 0
      current_item = @items.find {|item| item.product == product} 
      if current_item
          current_item.update_quantity(quantity)
      end
    else quantity = 0
      delete_product(product)
    end
  end
  
  def total
    total = 0
    if @items != []
      # how to use array.sum method to sum this array.
      @items.each {|item| total += item.subtotal }
      # total = @items.sum(:quantity)
    end
    total
  end
  
  def quantity
    quantity = 0
    if @items != []
      @items.each { |item| quantity += item.quantity }
    end
    quantity
  end
  
  def clear
    @items = []
  end
end
