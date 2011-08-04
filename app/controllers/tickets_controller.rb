# -*- encoding : utf-8 -*-
class TicketsController < ApplicationController
  
  # 身份验证  
  before_filter :authorize_admin!
  
  def index
    @tickets = Ticket.order("id desc").page(params[:page])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    
    if params[:count]
      Integer(params[:count]).times do |t|
        ticket = Ticket.new(params[:ticket])
        ticket.code = Ticket.new_code(params[:prefix])
        ticket.save
      end
    end
    
    respond_to do |format|
      format.html { redirect_to :action => :index }
    end

  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to(tickets_url) }
    end
  end
end
