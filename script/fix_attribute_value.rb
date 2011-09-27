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