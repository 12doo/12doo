# -*- encoding : utf-8 -*-
class TicketsController < ApplicationController
  
  # 身份验证  
  before_filter :authorize_admin!
  
  layout "application", :except => [:export]
  
  def index
    @tickets = get_tickets(true)
  end
  
  def export
    @tickets = get_tickets(false)
  end
  
  def show
    @ticket = Ticket.find_by_code(params[:code])
  end
  
  def new
    @ticket = Ticket.new
  end

  def create
    
    if params[:count]
      Integer(params[:count]).times do |t|
        ticket = Ticket.new(params[:ticket])
        ticket.code = Ticket.new_code(params[:prefix],Integer(params[:length]))
        ticket.save
      end
    end
    
    respond_to do |format|
      format.html { redirect_to :action => :index }
    end

  end

  private
  
  def get_tickets(pager)
    if params[:prefix] && params[:usable]
      if params[:usable] == ""
        tickets = Ticket.where("code like :prefix", :prefix => "#{params[:prefix]}%").order("id desc")
      else
        tickets = Ticket.where("code like :prefix and usable = :usable", :prefix => "#{params[:prefix]}%", :usable => params[:usable]).order("id desc")
      end
    else
      tickets = Ticket.order("id desc")
    end
    
    if pager
      tickets = tickets.page(params[:page])
    else
      tickets
    end
  end
  
end
