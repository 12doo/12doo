class OrdersController < ApplicationController
  # 身份验证
  before_filter :authorize_user!

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order.no = Time.now.strftime("SO%Y%m%d%H%M%S" )
    cart = find_cart
    cart.items.each do |item|
      temp = OrderItem.new
      temp.product_name = item.product.name
      temp.product_sku = item.product.sku
      temp.price = item.product.price
      temp.quantity = item.quantity
      temp.subtotal = item.subtotal
      @order.order_items << temp
    end

    @order.total = cart.total
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  def create
    if user_signed_in?
    @order = Order.new(params[:order])
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
        @order.zip = address.zips
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
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  else
    redirect_to :action => 'show', :controller => 'cart', :notice=>'sign in first!'
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
  
  private
  def find_cart
    session[:cart] ||= Cart.new
  end
end
