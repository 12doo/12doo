# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default :from => "12doo红酒网 <admin@12doo.com>"
 
  def welcome_email(user)
    @user = user
    mail(:to => "#{user.display_name} <#{user.email}>",
         :subject => "欢迎来到12度红酒网")
  end
  
end
