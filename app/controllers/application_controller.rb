# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  # 判断是否管理员
  def authorize_admin!
    unless current_user && current_user.admin
        sign_out
        redirect_to new_user_session_path + "?return_url=" + request.fullpath
    end
  end
 
  # 判断是否登陆
  def authorize_user!
    unless current_user
        redirect_to new_user_session_path + "?return_url=" + request.fullpath
    end
  end
  
  # 如果是管理员登陆,直接转到管理后台
  def after_sign_in_path_for(resource)
    if params[:return_url]
      return params[:return_url]
    elsif resource.is_a?(User) && resource.admin
      return "/admin"
    else
      return "/"
    end
  end
end
