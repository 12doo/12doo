# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  # 身份验证
  before_filter :authorize_user!, :except => [:notify, :done]

  def index
    @orders = Order.paginate :page => params[:page], :order => 'created_at DESC',:conditions => ['user_id = ?', current_user.id]
  end

  def show
    @order = Order.find(params[:id])
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
    
    cart = find_cart
    cart.items.each do |item|
      temp = OrderItem.new
      temp.product_id = item.product.id
      temp.user_id = current_user.id
      temp.product_name = item.product.name
      temp.product_sku = item.product.sku
      temp.price = item.product.price
      temp.quantity = item.quantity
      temp.subtotal = item.subtotal
      temp.order_no = @order.no
      temp.save
    end
    
    #temp test
    @order.total = 1
    
    respond_to do |format|
      if @order.save
        cart.clear
        if @order.pay_type == '支付宝'
          format.html { redirect_to :action => "check_out", :id => @order.id }
        else
          format.html { redirect_to :action => "info", :id => @order.id }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def check_out
    @order = Order.find(params[:id])
  end
  
  def info
    @order = Order.find(params[:id])
  end
  
  def notify
    order = Order.find(params[:id])
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    AlipayTxn.create(:notify_id => notification.notify_id, 
                     :total_fee => notification.total_fee, 
                     :status => notification.trade_status, 
                     :trade_no => notification.trade_no, 
                     :received_at => notification.notify_time)

    notification.acknowledge

    case notification.status
    when "WAIT_BUYER_PAY"
      order.status_code = "WAIT_BUYER_PAY"
      order.status = "等待付款"
      #@order.pend_payment!
    when "TRADE_FINISHED"
      order.status_code = "TRADE_FINISHED"
      order.status = "完成付款"
      #@order.pay!
    else
      #@order.fail_payment!
    end
    order.save
  end
  
  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)  
    unless @result = r.success?
      logger.warn(r.message)
    end  
  end


  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
  
  def get_coupon
    detail = Coupon.find_by_code(params[:code])
    if detail && detail.can_use(current_user,temp_order)
      respond_to do |format| 
        format.json { render :json => detail } 
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
      temp.product_name = item.product.name
      temp.product_sku = item.product.sku
      temp.price = item.product.price
      temp.quantity = item.quantity
      temp.subtotal = item.subtotal
      order.order_items << temp
    end
    order.total = cart.total
    order.quantity = cart.quantity
    return order
  end
end
