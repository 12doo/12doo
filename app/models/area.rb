# -*- encoding : utf-8 -*-
class Area < ActiveRecord::Base
  def get_provinces
    Area.where("province <> '' and city = ''")
  end
  
  def get_cities(province)
    Area.where(["province = ?",province])
  end
  
  def get_regions(province,city)
    Area.where(["province = ? and city = ?",province,city])
  end
end
