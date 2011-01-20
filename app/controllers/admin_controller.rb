class AdminController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    
  end
  
  def products
    @products = Product.paginate :page => params[:page], :order => 'created_at DESC'
  end
end
