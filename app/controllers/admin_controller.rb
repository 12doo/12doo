# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    
  end
  
  def products
    @products = Product.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def orders
    @orders = Order.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def users
    @users = User.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def coupons
    @coupons = Coupon.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
end
