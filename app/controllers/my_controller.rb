# -*- encoding : utf-8 -*-
class MyController < ApplicationController
  # 身份验证
  before_filter :authorize_user!
  
  def index
    @orders = current_user.orders.order("id desc").page(params[:page])
  end
  
  # address manage
  def addresses
    @addresses = current_user.addresses.order("id desc").page(params[:page])
  end
  
  def new_address
    @address = Address.new
  end
  
  def create_address
    @address = Address.new(params[:address])
    @address.user_id = current_user.id
    
    respond_to do |format|
      if @address.save
        if params[:default] == "true"
          @address.set_as_default
        else
          @address.default = false
          @address.save
        end
        format.html { redirect_to :action => "addresses" }
      else
        format.html { render :action => "new_address" }
      end
    end
  end
  
  def edit_address
    @address = Address.find(params[:id])
    unless @address.user_id == current_user.id
      redirect_to :action => "addresses"
    end
  end
  
  def update_address
    @address = Address.find(params[:id])
    if @address.user_id == current_user.id
      respond_to do |format|
        if @address.update_attributes(params[:address])
          if params[:default] == "true"
            @address.set_as_default
          else
            @address.default = false
            @address.save
          end
          format.html { redirect_to :action => "addresses" }
        else
          format.html { render :action => "edit_address" }
        end
      end
    else
      redirect_to :action => "addresses"
    end
  end
  
  def destroy_address
    @address = Address.find(params[:id])
    if @address.user_id == current_user.id
      @address.destroy
    end
    redirect_to :action => "addresses"
  end

  # orders
  def orders
    @orders = current_user.orders.order("id desc").page(params[:page])
  end
  
  # coupons
  def coupons
    @coupons = []
    current_user.coupons.each do |item|
      if item.available(current_user)
        @coupons << item
      end
    end
  end
  
  def bought
    sku = OrderItem.select("DISTINCT(order_items.product_sku)").joins('LEFT OUTER JOIN orders ON orders.id = order_items.order_id').where("orders.status = '订单完成'", "order_items.user_id" => current_user.id)
    skus = []
    sku.each do |item|
      skus << item.product_sku
    end
    @products = Product.where("sku in (:skus) and visiable = :visiable", :skus => skus, :visiable => true).order("id desc").page(params[:page])
  end
  
  def favorites
    @favorites = current_user.favorites.order("id desc").page(params[:page])
  end
  
  def update_password
    if current_user.update_with_password(params[:user])
      sign_out
      redirect_to '/'
    else
      render :change_password
    end
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
