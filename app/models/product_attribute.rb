# -*- encoding : utf-8 -*-
class ProductAttribute < ActiveRecord::Base
  belongs_to :category
  belongs_to :product
  belongs_to :product_attribute_value
  belongs_to :product_attribute_define
  paginates_per 20
  
  def init_from_value(product_attribute_value_id)
    value = ProductAttributeValue.find(product_attribute_value_id)
    self.description = value.product_attribute_define.description
    self.fix = value.product_attribute_define.fix
    self.multiple = value.product_attribute_define.multiple
    self.name = value.product_attribute_define.name
    self.value = value.value
    self.product_attribute_value_id = value.id
    self.category_id = value.category.id
    self.product_attribute_define_id = value.product_attribute_define.id
  end
  
  def init_from_define(product_attribute_define_id)
    define = ProductAttributeDefine.find(product_attribute_define_id)
    self.description = define.description
    self.fix = define.fix
    self.multiple = define.multiple
    self.name = define.name
    self.categroy_id = value.category.id
    self.product_attribute_define_id = value.product_attribute_define.id
  end
end
