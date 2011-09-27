# -*- encoding : utf-8 -*-
ProductAttributeValue.where(:product_attribute_define_id => 0, :category_id => 0).each do |item|
  item.category_id = 3
  if item.short == "l"
    item.product_attribute_define_id = 14
  end
  if item.short == "lev"
    item.product_attribute_define_id = 15
  end
  
  if item.short == "loc"
    item.product_attribute_define_id = 14
  end
  if item.short == 'volumn'
    item.product_attribute_define_id = 16
  end
  item.save
end

ProductAttribute.where(:product_attribute_define_id => 0).each do |item|
  if item.category_id == 0
    item.category_id = 3
    item.save
  end
    
  if item.product_attribute_value
    item.product_attribute_define_id = item.product_attribute_value.product_attribute_define_id
    item.save
  end
  
  unless item.product
    item.destroy
  end
  
  if item.value == ""
    item.destroy
  end
end

ProductAttribute.where(:product_id => nil).each do |item|
  item.destroy
end