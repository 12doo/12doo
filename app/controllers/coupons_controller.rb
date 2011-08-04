# -*- encoding : utf-8 -*-
class CouponsController < ApplicationController
  
  # 身份验证  
  before_filter :authorize_admin!
  
  layout "application", :except => [:export]

  def index
    @coupons = get_coupons(true)
  end
  
  def export
    @coupons = get_coupons(false)
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

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to(coupons_url) }
    end
  end
  
  private
  
  def get_coupons(pager)
    if params[:prefix] && params[:used_time]
      if params[:used_time] == ""
        coupons = Coupon.where("code like :prefix", :prefix => "#{params[:prefix]}%").order("id desc")
      else
        coupons = Coupon.where("code like :prefix and used_time = :used_time", :prefix => "#{params[:prefix]}%", :used_time => params[:used_time]).order("id desc")
      end
    else
      coupons = Coupon.order("id desc")
    end
    
    if pager
      coupons = coupons.page(params[:page])
    else
      coupons
    end
  end
  
end
