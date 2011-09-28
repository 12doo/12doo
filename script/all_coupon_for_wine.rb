# -*- encoding : utf-8 -*-
wine = Category.find_by_short("wine")
Coupon.update_all(:category_id => wine.id)