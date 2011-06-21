# -*- encoding : utf-8 -*-
class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute_value
  belongs_to :product_attribute_define
end
