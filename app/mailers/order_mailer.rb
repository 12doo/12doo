# -*- encoding : utf-8 -*-
class OrderMailer < ActionMailer::Base
  default :from => "admin@12doo.com"
 
  def order_confirm_email(order)
    @order = order
    @user = @order.user
    mail(:to => @user.email,
         :subject => "确认收到您的订单"+@order.no)
  end
  def order_inform_email(order)
    @order = order
    @user = @order.user
    mail(:to => "admin@12doo.com",
         :subject => "来自"+@user.email+"的订单"+@order.no+"，金额"+ format("%.2f", @order.pay_price))
  end  
end
