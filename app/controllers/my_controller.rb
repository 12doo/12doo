class MyController < ApplicationController
  # 身份验证
  before_filter :authorize_user!
  
  def index
    
  end
  
  def profile

  end

#  def update_profile
#    current_user.gender = params[:gender]
#    current_user.name = params[:name]
#    current_user.birth = Date.civil(params[:birth][:year].to_i, params[:birth][:month].to_i, params[:birth][:day].to_i)
#    logger.debug current_user.birth
#    current_user.save
#
#    respond_to do |format|
#      if current_user.save
#        format.html { redirect_to :action => "profile"}
#      else
#        format.html { render :action => "profile"  }
#      end
#    end
#    
#  end
end
