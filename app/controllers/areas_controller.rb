# -*- encoding : utf-8 -*-
class AreasController < ApplicationController
  def get_cities
    cities = Area.where(["province = ? and region = '' and city != ''", params[:province]])
    respond_to do |format|
          format.json { render :json => cities } 
    end
  end
  
  def get_regions
    regions = Area.where(["province = ? and city = ? and region != ''", params[:province], params[:city]])
    respond_to do |format| 
          format.json { render :json => regions } 
    end
  end
  
  def get_detail
    detail = Area.where(["province = ? and city = ? and region = ?", params[:province], params[:city], params[:region]])
    respond_to do |format| 
          format.json { render :json => detail } 
    end
  end
end
