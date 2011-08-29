# -*- encoding : utf-8 -*-
class ExchangesController < ApplicationController
  
  before_filter :authorize_admin!, :except => [:new, :create, :show]
  layout "application", :except => [:verify]
  
  def index
    @exchanges = Exchange.order("id desc").page(params[:page])
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
      @codes = params[:codes].split(/\s+/).delete_if{|code| code == ''}
    end
    
    @tickets = get_tickets
    
    @addresses = []
    if current_user
      @addresses = current_user.addresses
    end
    @years = (Time.now.year).upto(Time.now.year + 1).map{ |x| x }
    
    if @codes.count != @tickets.count
      useless = []
      get_useless_tickets.each do |item|
        useless << item.code
        @codes.delete_if{|code| code == item.code }
      end
      flash[:notice] = "提货券 #{useless.join('，')} 已经被使用。"
      
      respond_to do |format|
        format.html { redirect_to(:action => 'new', :codes => @codes.join(' ')) }
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end
  
  def self_take
    ticket = Ticket.find_by_code(params[:code])
    if ticket 
      if ticket.usable
        exchange = Exchange.new
        exchange.no = Time.now.strftime("EX%Y%m%d%H%M%S")
        address = Address.find(params[:address_id])
        exchange.set_address(address)
        ticket.usable = false
        ticket.used_at = Time.now
        exchange.tickets << ticket
        exchange.count = 1
        exchange.memo = '自提。'
        exchange.status = '等待确认'
        exchange.expected_time = Time.now
        exchange.save
        flash[:notice] = "提货券 #{params[:code]} 自提成功。"
      else
        flash[:notice] = "提货券 #{params[:code]} 已经被使用。"
      end
    else
      flash[:notice] = "提货券 #{params[:code]} 无法识别。"
    end
    respond_to do |format|
      format.html { redirect_to(:action => 'verify', :code => params[:code]) }
    end
  end
  
  def verify
    if params[:code] && params[:code] != ''
      @ticket = Ticket.find_by_code(params[:code])
      @addresses = []
      if current_user
        @addresses = current_user.addresses
      end

      if @ticket
        if @ticket.usable
          flash[:notice] = "提货券 #{params[:code]} 可以使用。"
        else
          flash[:notice] = "提货券 #{params[:code]} 已经被使用。"
        end
      else
        flash[:notice] = "提货券 #{params[:code]} 无法识别。"
      end
    end
  end

  def create
    if get_useless_tickets.count > 0
      codes = params[:codes].split(/\s+/).delete_if{|code| code == ''}
      useless = []
      get_useless_tickets.each do |item|
        useless << item.code
        codes.delete_if{|code| code == item.code }
      end
      flash[:notice] = "提货券 #{useless.join('，')} 已经被使用。"
      respond_to do |format|
        format.html { redirect_to(:action => 'new', :codes => codes.join(' ')) }
      end
    else
      tickets = get_tickets

      exchange = Exchange.new
      exchange.no = Time.now.strftime("EX%Y%m%d%H%M%S")
      address = nil
      #if select a exsit address
      if params[:address_id] == "0"
        address = Address.new(params[:address])
        #address.user_id = current_user.id
        address.save
      else
        address = Address.find(params[:address_id])
      end

      exchange.set_address(address)

      tickets.each do |item|
        item.usable = false
        item.used_at = Time.now
        exchange.tickets << item
      end

      exchange.count = tickets.count
      exchange.memo = params[:memo]
      exchange.status = '等待确认'
      exchange.expected_time = Time.local(params[:date][:year],params[:date][:month],params[:date][:day],params[:time])

      respond_to do |format|
        if exchange.save
          flash[:notice] = '我们已经收到您的提货预约，随后将会跟您取得联系。'
          format.html { redirect_to(:action => 'info', :controller => 'home') }
        end
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
