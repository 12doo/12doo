# -*- encoding : utf-8 -*-
class PicturesController < ApplicationController
  
  # 身份验证  
  before_filter :authorize_admin!
  
  layout false
  
  def index
    @pictures = Picture.order("id desc").page(params[:page])
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    @picture = Picture.new(params[:picture])
    respond_to do |format|
      if @picture.save
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
end
