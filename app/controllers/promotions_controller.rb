# -*- encoding : utf-8 -*-
class PromotionsController < ApplicationController
  def show
    @menu = params[:id]
    respond_to do |format|
      format.html { render :action => params[:id] }
    end
  end
end
