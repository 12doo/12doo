

  (1..99).each do |i|
    Product.create(
      :name => "Veramonte Reserva #{i}",
      :sku => "sku-#{i}",
      :price => 128,
      :indication_price => 168,
      :memo => "%{<p> Veramonte翠岭珍藏产自智利卡萨布兰卡山谷，作为帆船酒店的店酒闻名世界。</p>}",
      :visiable => true,
      :cn_name => "翠岭珍藏 #{i}",
      :count => i,
      :sold_count => i,
      :pic => i.to_s,
      :status => "ok"
      )
  end
  

