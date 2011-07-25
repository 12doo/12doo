# -*- encoding : utf-8 -*-
Product.find_each do |p|
  price = p.price
  if p.promo_price && p.promo_price > 0
    price = p.promo_price
  end
  item = ProductAttribute.where(:short => 'price', :product_id => p.id).first
  puts item
  if item
    string = '600以上'
    if price < 100
      string = '99以下'
    elsif price >= 100 and price < 200
      string = '100~199'
    elsif price >= 200 and price < 300
      string = '200~299'
    elsif price >= 300 and price < 600
      string = '300~599'
    end
  
    value = ProductAttributeValue.where(:short => 'price', :value => string).first
    item.value = value.value
    item.product_attribute_value_id = value.id
  
    item.save
  end
end

ProductAttribute.where(:product_id => nil).each do |item|
  item.destroy
end