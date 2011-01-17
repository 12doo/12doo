class MyController < ApplicationController
  # 身份验证
  before_filter :authorize_user!
  
  def index
    
  end
  
  def profile

  end

  def update_profile
    
  end
end
