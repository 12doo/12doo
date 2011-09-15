Category.new({:name => '葡萄酒', :short => 'wine'}).save
h = Category.new({:name => '健康食品', :short => 'healthfood'})
s = Category.new({:name => '时令食品', :short => 'seasonfood'})
o = Category.new({:name => '橄榄油', :short => 'oliveoil'})
h.categories << o
h.save
m = Category.new({:name => '月饼', :short => 'mooncake'})
s.categories << m
s.save