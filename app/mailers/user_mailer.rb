class UserMailer < ActionMailer::Base
  default :from => "admin@12doo.com"
  
  
  def welcome_email(user)
    @user = user
    @url  = "http://www.12doo.com"
    mail(:to => user.email,
         :subject => "欢迎来到12度红酒网.")
  end
  
end
