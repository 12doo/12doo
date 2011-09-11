# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  # 身份验证
  before_filter :authorize_admin!, :except => [:welcome, :confirm]
  def index
    @users = User.order("id desc").page(params[:page])
  end
  
  def show
  end
  
  def welcome
  end
  
  def confirm
  end
  
  def set_role
    if params[:role] && params[:id]
      user = User.find(params[:id])
      user.set_role(params[:role])
      user.save
    end
    
    redirect_to :action => :index
  end
  
end
