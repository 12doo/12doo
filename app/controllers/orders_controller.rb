# -*- encoding : utf-8 -*-

#TODO: Move some logistic to model
class OrdersController < ApplicationController
  # 身份验证
  before_filter :authorize_user!, :except => [:notify, :done]
  before_filter :authorize_admin!, :only => [:index, :delivery, :pay]
  
  # 普通用户列出所有订单的操作在 /my/index 或 /my/orders 中，此处只允许管理员操作
  def index
    @orders = Order.order("id desc").page(params[:page])
  end
  
  # 普通 用户 和管理员用同一个 action 
  def show
    @order = Order.find(params[:id])
    unless @order.user_id == current_user.id || current_user.admin
      redirect_to :action => :orders, :controller => :my
    end
    
  end
  
  # 创建新订单
  def new
    cart = find_cart
    if cart.quantity == 0
      respond_to do |format|
        format.html { redirect_to :action => "show", :controller => "cart" }
      end
    else
      @order = temp_order
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    
    change = OrderChange.new
    change.user_id = current_user.id
    change.before = ''
    
    @order = temp_order
    @order.status = '等待确认订单';
    @order.memo = params[:memo]
    @order.pay_type = params[:pay_type]
    if @order.pay_type == '支付宝'
      @order.status = '等待付款'
    end
    
    change.after = @order.status
    change.changed_at = Time.now
    
    address = nil
    
    #if select a exsit address
    if params[:address_id] == "0"
      address = Address.new(params[:address])
      address.user_id = current_user.id
      address.save
    else
      address = Address.find(params[:address_id])
    end
    
    @order.set_address(address)
    
    #coupon
    if params[:coupon_code]
      coupon = Coupon.find_by_code(params[:coupon_code])
      @order.use_coupon(coupon, current_user)
    end
    cart = find_cart
    respond_to do |format|
      if @order.save
        cart.clear
        change.order_id = @order.id
        change.save
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
  
  #去付款的界面
  def check_out
    @order = Order.find(params[:id])
    unless @order.status == '等待付款'
      flash[:info] = '您的订单 ' + @order.no + ' 目前无法支付，这有可能因为已经完成付款或者需要等待确认金额。';
      format.html { render :action => "info" }
    end
  end
  
  #接受支付宝返回状态，以支付状态识别，无须用户验证
  def notify
    order = Order.find(params[:id])
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)
    notification.acknowledge

    case notification.status
    when "TRADE_SUCCESS"
      
      change = OrderChange.new
      change.user_id = order.user_id
      change.before = order.status
      
      order.status = "等待发货"
      order.pay_at = Time.now
      
      change.after = order.status
      change.changed_at = Time.now
      change.save
      
    else
      order.status = notification.status
    end
    order.save
    
    #将支付宝返回内容记录下来，无论是否对应订单
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
  
  #成功支付后的信息页面
  def done
    order = Order.find(params[:id])
    flash[:info] = '您的订单 ' + order.no + ' 已经支付完成，我们将尽快为您安排配送。';
    respond_to do |format|
        format.html { render :action => "info" }
    end
  end
  
  #用户可以取消 TODO：可能需要根据状态判断是否可以进行取消操作
  #当前管理员界面没有取消订单的途径，因此只返回到用户界面
  def cancel
    @order = Order.find(params[:id])
    if @order && @order.user_id == current_user.id
      
      @order.cancel(current_user)
    end
    redirect_to :action => :orders, :controller => :my
  end
  
  
  def confirm
    @order = Order.find(params[:id])
    @order.confirm(current_user)
    
    redirect_to orders_path
  end
  
  # 用户确认收货的操作，只在用户界面 /my/orders 显示该操作链接
  def receive
    @order = Order.find(params[:id])
    @order.receive(current_user)
    
    #因此只返回到用户界面 /my/orders
    redirect_to :action => :orders, :controller => :my
  end
  
  #发货操作，只允许后台管理员进行
  def delivery
    @order = Order.find(params[:id])
    
    change = OrderChange.new
    change.user_id = @order.user_id
    change.before = @order.status
     
    @order.status = '等待确认收货'
    @order.save
    
    change.after = @order.status
    change.changed_at = Time.now
    change.save
    
    # create dispatch
    dispatch = Dispatch.new
    dispatch.no = Time.now.strftime("DP%Y%m%d%H%M%S")
    dispatch.order_no = @order.no
    dispatch.order_total = @order.total
    dispatch.order_carriage = @order.carriage
    dispatch.order_fullname = @order.fullname
    dispatch.order_address = @order.address
    dispatch.order_province = @order.province
    dispatch.order_city = @order.city
    dispatch.order_region = @order.region
    dispatch.order_zip = @order.zip
    dispatch.order_phone = @order.phone
    dispatch.order_delivery_type = @order.delivery_type
    dispatch.order_pay_price = @order.pay_price
    dispatch.order_discount = @order.discount
    dispatch.order_quantity = @order.quantity
    dispatch.order_memo = @order.memo
    dispatch.order_pay_type = @order.pay_type
    
    @order.order_items.each do |item|
      dispatch_item = DispatchItem.new
      dispatch_item.product_id = item.product_id
      dispatch_item.product_name = item.product_name
      dispatch_item.product_price = item.price
      dispatch_item.product_sku = item.product_sku
      dispatch_item.quantity = item.quantity
      dispatch_item.subtotal = item.subtotal
      dispatch.dispatch_items << dispatch_item
    end
    
    dispatch.save

    redirect_to :action => :index, :controller => :orders
  end
  
  #管理员确认订单已付的操作，只允许管理员进行
  def pay
    @order = Order.find(params[:id])
    
    change = OrderChange.new
    change.user_id = @order.user_id
    change.before = @order.status
     
    @order.status = '等待发货'
    @order.save
    
    change.after = @order.status
    change.changed_at = Time.now
    change.save
    
    redirect_to :action => :index, :controller => :orders
  end
  
  def get_coupon
    detail = Coupon.find_by_code(params[:code])
    if detail && detail.can_use(current_user, temp_order)
      respond_to do |format| 
        format.json { render :json => detail } 
      end
    else
      respond_to do |format| 
        format.json { render :json => nil } 
      end
    end
  end
  
  def get_carriage
    respond_to do |format| 
      format.json { render :json => Order.get_carriage(params[:total].to_f) } 
    end
  end
  
  private
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def temp_order
    order = Order.new
    cart = find_cart
    order.init_from_cart(cart, current_user)
    order
  end
end
