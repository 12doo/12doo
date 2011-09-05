order_items = OrderItem.all
order_items.each do |item|
  if item.order_id == nil
    item.destroy
  else
    if item.product_id == nil
      product = Product.find_by_sku(item.product_sku)
      if product == nil
        item.destroy
      else
        item.product_id = product.id
        item.save
      end
    end
    
    if item.order_no == nil
      if item.order ==  nil
        item.destroy
      else
        item.order_no = item.order.no
        item.user_id = item.order.user.id
        item.save
      end
    end
  end
end