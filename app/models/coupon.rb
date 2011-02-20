class Coupon < ActiveRecord::Base
  has_many :coupon_used_records
  
  # 判断是否可用
  def can_use(user,order)
    result = false
    # 判断优惠券生效时间范围,价格是否适用
    if self.begin < Time.now && self.end > Time.now && self.threshold_match(order)
      # 判断优惠券是否是多人使用券
      if self.all_user
        # 是多人优惠券,如果不是一次性并且已经使用过,都返回true
        unless self.one_off && self.used(user)
          result = true
        end
      else
        # 是单人优惠券,是否是当前用户的
        if self.user_id == user.id
          # 除非是一次性并且已经用过的,其余都返回true
          unless self.one_off && self.used(user)
            result = true
          end
        end
      end
    end
  
    return result
  end
  
  # 判断某个人是否使用过该券
  def used(user)
    record = CouponUsedRecord.find_by_user_id(user.id)
    if record
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
end
