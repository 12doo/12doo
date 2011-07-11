# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
  
  after_create :send_order_confirm_email
  
  has_many :order_items
  has_many :order_changes
  
  belongs_to :user
  paginates_per 10
  
  def init_from_cart(cart, user)
    self.no = Time.now.strftime("SO%Y%m%d%H%M%S")
    self.order_at = Time.now
    self.user_id = user.id
    self.total = 0
    self.quantity = 0
    cart.items.each do |item|
      order_item = item.get_order_item
      order_item.user_id = user.id
      order_item.order_no = self.no
      self.order_items << order_item
      self.total += item.subtotal
      self.quantity += item.quantity
    end
    
    self.carriage = 0
    
    #计算运费，当前只有20一档和满200免运费优惠
    if self.total < 200
      self.carriage = 20
    end
    
    self.discount_rate = 1
    self.discount = self.total * (1 - self.discount_rate)
    
    self.pay_price = self.carriage + self.total * self.discount_rate
  end
  
  def use_coupon(coupon, user)
    if coupon && coupon.can_use(user, self)
      self.pay_price = self.carriage + self.total * self.discount_rate - coupon.discount
      self.coupon_discount = coupon.discount
      self.coupon_code = coupon.code
      coupon.use(user, self)
    end
  end
  
  # 取消订单
  def cancel(user)
    change = OrderChange.new
    change.user_id = self.user_id
    change.before = self.status

    self.status = '订单取消'

    change.after = self.status
    change.changed_at = Time.now
    self.order_changes << change
    
    self.save
    
    if self.coupon_code
      coupon = Coupon.find_by_code(coupon_code)
      if coupon
        coupon.restore(user,self)
      end
    end
  end
  
  def set_address(address)
    self.fullname = address.name
    self.address = address.detail
    self.province = address.province
    self.city = address.city
    self.region = address.region
    self.zip = address.zip
    self.phone = address.phone
    self.address_id = address.id
  end
    
  def send_order_confirm_email
    OrderMailer.order_confirm_email(self).deliver
    OrderMailer.order_inform_email(self).deliver
  end
end
