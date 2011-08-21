# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  # 身份验证  
  before_filter :authorize_admin!
  def index
    @users = User.order("id desc").page(params[:page])
  end
  
  def show
    
  end
  
end
