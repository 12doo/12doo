w = Category.find_by_short("wine")
Product.all.each do |item|
  item.category = w
  item.save
end