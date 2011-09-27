# -*- encoding : utf-8 -*-
class ProductAttribute < ActiveRecord::Base
  belongs_to :category
  belongs_to :product
  belongs_to :product_attribute_value
  belongs_to :product_attribute_define
  paginates_per 20
  
  def init_from_value(product_attribute_value_id)
    value = ProductAttributeValue.find(product_attribute_value_id)
    self.value = value.value
    self.product_attribute_value_id = value.id
    self.category_id = value.category.id
    self.product_attribute_define_id = value.product_attribute_define.id
  end
  
  def init_from_define(product_attribute_define_id)
    define = ProductAttributeDefine.find(product_attribute_define_id)
    self.category_id = define.category.id
    self.product_attribute_define_id = define.id
  end
end
