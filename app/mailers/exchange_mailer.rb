# -*- encoding : utf-8 -*-
class ExchangeMailer < ActionMailer::Base
  default :from => "admin@12doo.com"
 
  def exchange_inform_email(exchange)
    @exchange = exchange
    mail(:to => 'admin@12doo.com',
         :subject => "收到新提货预约" + exchange.no)
  end
  
end