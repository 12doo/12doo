# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
  
  after_create :send_order_confirm_email
  
  has_many :order_items
  has_many :order_changes
  
  belongs_to :user
  paginates_per 20
  
  def can_use_coupons(user)
    coupons = []
    user.coupons.each do |coupon|
      if coupon.can_use(user,self)
        coupons << coupon
      end
    end
    coupons
  end
  
  #某个分类下产品采购价格,支持子分类
  def subtotal_of_category(category)
    subtotal = 0
    
    self.order_items.each do |item|
      if item.product.category_id == category.id
        subtotal = subtotal + item.subtotal
      end
    end
    
    category.categories.each do |item|
      subtotal = subtotal + self.subtotal_of_category(item)
    end
    
    return subtotal
  end
  
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
    
    self.carriage = Order.get_carriage(self.total)
    
    self.discount_rate = 1
    self.discount = self.total * (1 - self.discount_rate)
    
    self.pay_price = self.carriage + self.total * self.discount_rate
  end
  
  def self.get_carriage(total)
    #计算运费，当前只有20一档和满200免运费优惠
    if total < 200
      20
    else
      0
    end
  end
  
  def use_coupon(coupon, user)
    if coupon && coupon.can_use(user, self)
      self.pay_price = self.carriage + self.total * self.discount_rate - coupon.discount
      self.coupon_discount = coupon.discount
      self.coupon_code = coupon.code
      coupon.use(user, self)
    end
  end
  
  def confirm(user)
      change = OrderChange.new
      change.user_id = user.id
      change.before = self.status

      self.status = '等待发货'
      self.save

      change.after = self.status
      change.changed_at = Time.now
      change.save
  end
  
  def receive(user)
      change = OrderChange.new
      change.user_id = user.id
      change.before = self.status

      self.status = '订单完成'
      self.save

      change.after = self.status
      change.changed_at = Time.now
      change.save
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
