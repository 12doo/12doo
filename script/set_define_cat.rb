w = Category.find_by_short("wine")
ProductAttributeDefine.all.each do |item|
  item.category = w
  item.save
end