# -*- encoding : utf-8 -*-
class ExchangesController < ApplicationController
  
  before_filter :authorize_admin!, :except => [:new, :create, :show]

  def index
    @exchanges = Exchange.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @exchange = Exchange.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new

    @codes = []
    if params[:codes]
      @codes = params[:codes].split(/\s/)
    end
    
    @tickets = get_tickets
    
    if @codes.count <> @tickets.count
      useless = []
      get_useless_tickets.each do |item|
        useless << item.code
      end
      flash[:notice] = "提货券 #{useless.join('，')} 已经被使用。"
    end
    
    @addresses = []
    if current_user
      @addresses = current_user.addresses
    end
    
    @years = (Time.now.year).upto(Time.now.year + 1).map{ |x| x }

    respond_to do |format|
      format.html
    end
  end

  # GET /exchanges/1/edit
  def edit
    @exchange = Exchange.find(params[:id])
  end

  # POST /exchanges
  # POST /exchanges.xml
  def create
    exchange = Exchange.new
    exchange.no = Time.now.strftime("SO%Y%m%d%H%M%S")
    address = nil
    #if select a exsit address
    if params[:address_id] == "0"
      address = Address.new(params[:address])
      address.user_id = current_user.id
      address.save
    else
      address = Address.find(params[:address_id])
    end
    
    exchange.set_address(address)
    tickets = get_tickets
    tickets.each do |item|
      item.usable = false
      item.used_at = Time.now
      exchange.tickets << item
    end
    
    exchange.count = tickets.count
    exchange.memo = params[:memo]
    exchange.expected_time = Time.local(params[:date][:year],params[:date][:month],params[:date][:day],params[:time])

    respond_to do |format|
      if exchange.save
        flash[:notice] = '我们已经收到您的提货预约，随后将会跟您取得联系。'
        format.html { redirect_to(:action => 'info', :controller => 'home') }
      else
        flash[:notice] = '保'
        format.html { render :action => "new", :codes => params[:codes] }
      end
    end
  end

  # PUT /exchanges/1
  # PUT /exchanges/1.xml
  def update
    @exchange = Exchange.find(params[:id])

    respond_to do |format|
      if @exchange.update_attributes(params[:exchange])
        format.html { redirect_to(@exchange, :notice => 'Exchange was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exchange.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exchanges/1
  # DELETE /exchanges/1.xml
  def destroy
    @exchange = Exchange.find(params[:id])
    @exchange.destroy

    respond_to do |format|
      format.html { redirect_to(exchanges_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_tickets
    codes = []
    if params[:codes]
      codes = params[:codes].split(/\s/)
    end
    
    tickets = []
    if params[:codes]
      tickets = Ticket.where("code in (:codes) and usable = :usable", :codes => codes, :usable => true).order('id desc')
    end
    
    tickets
  end
  
  def get_useless_tickets
    codes = []
    if params[:codes]
      codes = params[:codes].split(/\s/)
    end
    
    tickets = []
    if params[:codes]
      tickets = Ticket.where("code in (:codes) and usable = :usable", :codes => codes, :usable => false).order('id desc')
    end
    
    tickets
  end
  
end
