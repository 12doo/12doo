# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    
  end
  
  def products
    @products = Product.order("id desc").page(params[:page])
  end
  
  def orders
    @orders = Order.order("id desc").page(params[:page])
  end
  
  def users
    @users = User.order("id desc").page(params[:page])
  end
  
  def coupons
    @coupons = Coupon.order("id desc").page(params[:page])
  end
  
end
