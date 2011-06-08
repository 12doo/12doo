# -*- encoding : utf-8 -*-
class OrderMailer < ActionMailer::Base
  default :from => "admin@12doo.com"
 
  def order_confirm_email(order)
    @order = order
    @user = @order.user
    mail(:to => @user.email,
         :subject => "收到 您的订购")
  end
  
end
