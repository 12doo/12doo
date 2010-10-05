class Cart 
  attr_reader :items
  def initialize 
    @items = []
  end

  def add_product(product,quantity = 1)
    if quantity > 0
      current_item = @items.find {|item| item.product == product} 
      if current_item
        current_item.update_quantity(current_item.quantity + quantity)
        @total += current_item.subtotal
      else
        @items << CartItem.new(product,quantity)
      end
    end
  end
  
  def delete_product(product)
    current_item = @items.find {|item| item.product == product} 
    if current_item
      @items.delete(current_item)
    end
  end
  
  def remove_product(product,quantity = 1)
    if quantity > 0
      current_item = @items.find {|item| item.product == product} 
      if current_item
        if curent_item.quantity > quantity
          current_item.update_quantity(current_item.quantity - quantity)
        else
          delete_product(product)
        end
      end
    else quantity = 0
      delete_product(product)
    end
  end
  
  def total
    total = 0
    if @items != []
      @items.each do |item|
        total += item.subtotal
      end
    end
    total
  end
  
  def clear
    @items = []
  end
end