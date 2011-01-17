class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  # 判断是否管理员
  def authorize_admin!
    if current_user && current_user.admin
    else
      redirect_to new_user_session_path
    end
  end
 
  # 判断是否登陆
  def authorize_user!
    unless current_user
      redirect_to new_user_session_path
    end
  end
  
  # 如果是管理员登陆,直接转到管理后台
  def after_sign_in_path_for(user)
    if user.admin
      return "/admin"
    end
  end
end
