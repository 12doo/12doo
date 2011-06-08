# -*- encoding : utf-8 -*-
class OrderChangesController < ApplicationController
  
  before_filter :authorize_admin!
  
  def index
    @changes = OrderChange.order("id desc").page(params[:page])
  end
end
