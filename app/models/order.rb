# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
  
  after_create :send_order_confirm_email
  
  has_many :order_items
  belongs_to :user
  paginates_per 10
    
  def send_order_confirm_email
    Thread.start do 
      OrderMailer.order_confirm_email(self).deliver
    end
  end
end
