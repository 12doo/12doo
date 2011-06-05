# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    @orders = Order.order("id desc").page(params[:page])
    
  end
  
  def products
    @products = Product.order("id desc").page(params[:page])
  end
  
  def orders
    
  end
  
  def users
    @users = User.order("id desc").page(params[:page])
  end
  
end
