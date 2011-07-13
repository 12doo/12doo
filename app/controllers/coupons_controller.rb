# -*- encoding : utf-8 -*-
class CouponsController < ApplicationController
  
  # 身份验证  
  before_filter :authorize_admin!

  def index
    @coupons = Coupon.order("id desc").page(params[:page])
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @coupon = Coupon.new
  end
  
  def batch_new
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def create
    @coupon = Coupon.new(params[:coupon])

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to :action => :index, :controller => :coupons }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
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
