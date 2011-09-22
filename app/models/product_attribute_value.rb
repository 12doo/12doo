# -*- encoding : utf-8 -*-
class ProductAttributeValue < ActiveRecord::Base
  belongs_to :category
  has_many :product_attributes
  belongs_to :product_attribute_define
  paginates_per 20
  
  def init_from_define(product_attribute_define_id)
    value = ProductAttributeValue.find(product_attribute_define_id)
    self.short = define.short
    self.description = define.description
    self.product_attribute_value_id = value.id
    self.fix = define.fix
    self.multiple = define.multiple
    self.name = define.name
    temp.value = value
  end
  
end
