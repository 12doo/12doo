# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    @orders = Order.order("id desc").page(params[:page])
    
  end
  
end
