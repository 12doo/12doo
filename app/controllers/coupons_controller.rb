# -*- encoding : utf-8 -*-
class CouponsController < ApplicationController
  
  # 身份验证  
  before_filter :authorize_admin!

  def index
    if params[:prefix] && params[:used_time]
      if params[:used_time] == ""
        @coupons = Coupon.where("code like :prefix", :prefix => "#{params[:prefix]}%").order("id desc").page(params[:page])
      else
        @coupons = Coupon.where("code like :prefix and used_time = :used_time", :prefix => "#{params[:prefix]}%", :used_time => params[:used_time]).order("id desc").page(params[:page])
      end
    else
      @coupons = Coupon.order("id desc").page(params[:page])
    end
  end

  def new
    @coupon = Coupon.new
  end

  def create
    if params[:type]
      case params[:type]
        when "create"
          
          if params[:count]
            Integer(params[:count]).times do |t|
              coupon = Coupon.new(params[:coupon])
              coupon.code = Coupon.new_code(params[:prefix])
              coupon.save
            end
          end
          

        when "import"
          
          if params[:codes]
            params[:codes].split(',').each do |item|
              coupon = Coupon.new(params[:coupon])
              coupon.code = item
              coupon.save
            end
          end
          
      end
    end

    
    respond_to do |format|
      format.html { redirect_to :action => :index, :controller => :coupons }
    end
  end

  def update
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to(@coupon, :notice => 'Coupon was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to(coupons_url) }
      format.xml  { head :ok }
    end
  end
end
