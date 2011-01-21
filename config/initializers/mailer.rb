ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "12doo.net",  
  :user_name            => "admin@12doo.net",  
  :password             => "Password01",  
  :authentication       => "plain",
  :enable_starttls_auto => true  
}
