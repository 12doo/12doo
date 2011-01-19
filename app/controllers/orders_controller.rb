class OrdersController < ApplicationController
  # 身份验证
  before_filter :authorize_user!

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = temp_order
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  def create
    @order = temp_order
    @order.no = Time.now.strftime("SO%Y%m%d%H%M%S")
    @order.status = 'Init';
    @order.order_at = Time.now
    @order.user_id = current_user.id
    
    #if select a exsit address
    if params[:address_id]
      address = Address.new(params[:address_id])
      
      #check hack
      #if address && address.user_id == current_user.id
        @order.fullname = address.name
        @order.address = address.detail
        @order.province = address.province
        @order.city = address.city
        @order.region = address.region
        @order.zip = address.zip
        @order.phone = address.phone
      #end
    else
      address = Address.new
      address.user_id = current_user.id
      address.name = @order.fullname
      address.detail = @order.address
      address.province = @order.province
      address.city = @order.city
      address.region = @order.region
      address.zip = @order.zip
      address.phone = @order.phone
      address.save
    end
    
    cart = find_cart
    cart.items.each do |item|
      temp = OrderItem.new
      temp.product_name = item.product.name
      temp.product_sku = item.product.sku
      temp.price = item.product.price
      temp.quantity = item.quantity
      temp.subtotal = item.subtotal
      temp.order_no = @order.no
      temp.save
    end
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to :action => "check_out", :id => @order.id }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def check_out
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
    return order
  end
end
