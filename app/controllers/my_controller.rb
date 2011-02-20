class MyController < ApplicationController
  # 身份验证
  before_filter :authorize_user!
  
  def index
    
  end
  
  def profile

  end

  def bought
    @products = current_user.order_items.product
    @products.each do |item|
      logger.debug(item)
    end
    #@products = Product.join().where(:sku => skus, :visiable => true).paginate(:page => params[:page], :order => sort_by + ' ' + sort)
  end

#  def update_profile
#    current_user.gender = params[:gender]
#    current_user.name = params[:name]
#    current_user.birth = Date.civil(params[:birth][:year].to_i, params[:birth][:month].to_i, params[:birth][:day].to_i)
#    logger.debug current_user.birth
#    current_user.save
#
#    respond_to do |format|
#      if current_user.save
#        format.html { redirect_to :action => "profile"}
#      else
#        format.html { render :action => "profile"  }
#      end
#    end
#    
#  end
end
