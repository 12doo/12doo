# -*- encoding : utf-8 -*-
Coupon.all.each do |coupon|
  coupon.destroy
end
CouponUsedRecord.all.each do |record|
  record.destroy
end
User.all.each do |user|
  user.sign_in_count = 0
  coupon = Coupon.new_for_register(user)
  if coupon
    coupon.save
  end
end