# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
  
  after_create :send_order_confirm_email
  
  has_many :order_items
  belongs_to :user
  paginates_per 10
  
  def init_from_cart(cart)
    self.no = Time.now.strftime("SO%Y%m%d%H%M%S")
    self.total = 0
    self.quantity = 0
    cart.items.each do |item|
      self.order_items << item.get_order_item
      self.total += item.subtotal
      self.quantity += item.quantity
    end
    
    self.carriage = 0
    
    #计算运费，当前只有20一档和满200免运费优惠
    if self.total < 200
      self.carriage = 20
    end
    
    self.pay_price = self.carriage + self.total
  end
  
  def calc_order_price
   #self.order_items
   
  end
    
  def send_order_confirm_email
    OrderMailer.order_confirm_email(self).deliver
    OrderMailer.order_inform_email(self).deliver
  end
end
