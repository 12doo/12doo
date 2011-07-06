# -*- encoding : utf-8 -*-
class Coupon < ActiveRecord::Base
  has_many :coupon_used_records
  paginates_per 10
  
  # 判断是否可用
  def can_use(user, order)
    result = false
    # 判断优惠券生效时间范围,价格是否适用
    if self.begin < Time.now && self.end > Time.now && self.threshold_match(order)
      # 判断优惠券是否是多人使用券
      if self.all_user
        # 是多人优惠券,如果不是一次性并且已经使用过,都返回true
        if self.one_off && self.used(user)
          result = false
        else
          result = true
        end
      else
        # 是单人优惠券,是否是当前用户的
        if self.belongs_to == user.id
          # 除非是一次性并且已经用过的,其余都返回true
          if self.one_off && self.used(user)
            result = false
          else
            result = true
          end
        end
      end
    end
  
    return result
  end
  
  # 判断某个人是否使用过该券
  def used(user)
    record = CouponUsedRecord.where(:user_id => user.id, :coupon_code => self.code)
    if record && record.count > 0
      return true
    end
    return false
  end
  
  # 判断订单价格是否适用
  def threshold_match(order)
    if order.total >= self.threshold
      return true
    else
      return false
    end
  end
  
  # 使用该券
  def use(user,order)
    record = CouponUsedRecord.new
    record.user_id = user.id
    record.order_id = order.id
    record.order_no = order.no
    record.use_at = Time.now
    record.coupon_id = self.id
    record.coupon_code = self.code
    record.save
    self.used_time += 1
    self.save
  end
  
  # 用户注册送coupon
  def self.new_for_register(user)
    if user.sign_in_count == 0
      coupon = Coupon.new
      coupon.code = new_code
      coupon.discount = 20
      
      if user.id <= 100
        coupon.discount = 50
      end
      
      coupon.threshold = 100
      coupon.belongs_to = user.id
      coupon.all_user = false
      coupon.one_off = true
      coupon.begin = Time.now
      coupon.end = Time.now + 1.year
      coupon.used_time = 0
      coupon.save
      coupon
    end
    nil
  end
  
  def self.new_code
    chars = ("a".."z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(10) { |i| newpass << chars[rand(chars.size-1)] }
    
    # 查看重复
    if Coupon.find_by_code(newpass)
      self.new_code
    else
      newpass
    end
  end
  
end
