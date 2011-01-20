class AdminController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    
  end
  
end
