Product.all.each do |item|
  item.promo_price = 0
  item.save
end