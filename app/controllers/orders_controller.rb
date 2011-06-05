# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  # 身份验证
  before_filter :authorize_user!, :except => [:notify, :done]
  
  def index
    @orders = Order.order("id desc").page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    unless @order.user_id == current_user.id || current_user.admin
      redirect_to :action => :orders, :controller => :my
    end
    
  end

  def new
    cart = find_cart
    if cart.quantity == 0
      respond_to do |format|
        format.html { redirect_to :action => "show", :controller => "cart" }
      end
    else
      @order = temp_order
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @order }
      end
    end
  end

  def create
    @order = temp_order
    @order.no = Time.now.strftime("SO%Y%m%d%H%M%S")
    @order.status = '等待确认订单';
    @order.memo = params[:memo]
    @order.order_at = Time.now
    @order.user_id = current_user.id
    @order.pay_type = params[:pay_type]
    if @order.pay_type == '支付宝'
      @order.status = '等待付款'
    end
    
    address = nil
    
    #if select a exsit address
    if params[:address_id] == "0"
      address = Address.new(params[:address])
      address.user_id = current_user.id
      address.save
    else
      address = Address.find(params[:address_id])
    end
   
    @order.fullname = address.name
    @order.address = address.detail
    @order.province = address.province
    @order.city = address.city
    @order.region = address.region
    @order.zip = address.zip
    @order.phone = address.phone 
    
    #@order.pay_price = 0.01
    
    cart = find_cart
    cart.items.each do |item|
      temp = OrderItem.new
      temp.product_id = item.product.id
      temp.user_id = current_user.id
      temp.product_name = item.product.cn_name
      temp.product_sku = item.product.sku
      temp.price = item.product.price
      temp.quantity = item.quantity
      temp.subtotal = item.subtotal
      temp.order_no = @order.no
      temp.save
    end
    
    #coupon
    if params[:coupon_code]
      coupon = Coupon.find_by_code(params[:coupon_code])
      if coupon && coupon.can_use(current_user,temp_order)
        @order.pay_price = @order.total - coupon.discount
        @order.discount = coupon.discount
        @order.coupon_code = params[:coupon_code]
        coupon.use(current_user, @order)
      end
    end
    
    respond_to do |format|
      if @order.save
        cart.clear
        if @order.pay_type == '支付宝'
          format.html { redirect_to :action => "check_out", :id => @order.id }
        else
          flash[:info] = '我们已经收到您的订单 ' + @order.no + ' ，完成确认后我们将尽快为您安排配送。';
          format.html { render :action => "info" }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def check_out
    @order = Order.find(params[:id])
    unless @order.status == '等待付款'
      flash[:info] = '您的订单 ' + @order.no + ' 目前无法支付，这有可能因为已经完成付款或者需要等待确认金额。';
      format.html { render :action => "info" }
    end
  end
  
  def notify
    order = Order.find(params[:id])
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)
    notification.acknowledge

    case notification.status
    when "TRADE_SUCCESS"
      order.status = "等待发货"
      order.pay_at = Time.now
    else
      @order.status = notification.status
    end
    order.save
    
    alipay = AlipayLog.new
    alipay.notify_type = notification.notify_type
    alipay.notify_id = notification.notify_id
    alipay.out_trade_no = notification.out_trade_no
    alipay.trade_no = notification.trade_no
    alipay.payment_type = notification.payment_type
    alipay.subject = notification.subject
    alipay.body = notification.body
    alipay.seller_email = notification.seller_email
    alipay.seller_id = notification.seller_id
    alipay.buyer_email = notification.buyer_email
    alipay.buyer_id = notification.buyer_id
    alipay.price = notification.price
    alipay.quantity = notification.quantity
    alipay.total_fee = notification.total_fee
    alipay.trade_status = notification.trade_status
    alipay.refund_status = notification.refund_status
    alipay.notify_time = notification.notify_time
    alipay.save
    
    flash[:info] = 'Hello Alipay。';
    respond_to do |format|
      format.html { render :action => "info" }
    end
  end
  
  def done
    order = Order.find(params[:id])
    flash[:info] = '您的订单 ' + order.no + ' 已经支付完成，我们将尽快为您安排配送。';
    respond_to do |format|
        format.html { render :action => "info" }
    end
  end

  def cancel
    @order = Order.find(params[:id])
    if @order.user_id == current_user.id
      @order.status = '订单取消'
      @order.save
    end
    redirect_to :action => :orders, :controller => :my
  end
  
  def confirm
    @order = Order.find(params[:id])
    @order.status = '等待发货'
    @order.save
    redirect_to :action => :index, :controller => :orders
  end
  
  def delivery
    @order = Order.find(params[:id])
    @order.status = '等待确认收货'
    @order.save
    redirect_to :action => :index, :controller => :orders
  end
  
  def pay
    @order = Order.find(params[:id])
    @order.status = '等待发货'
    @order.save
    redirect_to :action => :index, :controller => :orders
  end
  
  def get_coupon
    detail = Coupon.find_by_code(params[:code])
    if detail && detail.can_use(current_user,temp_order)
      respond_to do |format| 
        format.json { render :json => detail } 
      end
    else
      respond_to do |format| 
        format.json { render :json => nil } 
      end
    end
  end
  
  private
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def temp_order
    order = Order.new
    order.no = Time.now.strftime("SO%Y%m%d%H%M%S")
    cart = find_cart
    cart.items.each do |item|
      temp = OrderItem.new
      temp.product_name = item.product.cn_name
      temp.product_sku = item.product.sku
      temp.price = item.product.price
      temp.quantity = item.quantity
      temp.subtotal = item.subtotal
      order.order_items << temp
    end
    order.total = cart.total
    
    if order.total < 200
      order.carriage = 20
    else
      order.carriage = 0
    end
    order.pay_price = order.carriage + order.total
    order.quantity = cart.quantity
    return order
  end
end
