# -*- encoding : utf-8 -*-
module ProductAttributeDefinesHelper
  def get_attribute_define_id_by_short(short)
    item = ProductAttributeDefine.find_by_short(short)
    if item
      return item.id
    else
      return 0
    end
  end
  
  def get_attribute_define_sort_by_short(short)
    item = ProductAttributeDefine.find_by_short(short)
    if item
      return item.sort
    else
      return 0
    end
  end
end
