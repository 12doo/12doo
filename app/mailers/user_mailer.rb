# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default :from => "admin@12doo.com"
 
  def welcome_email(user)
    @user = user
    mail(:to => @user.email,
         :subject => "欢迎来到12度红酒网")
  end
  
end
