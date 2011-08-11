# -*- encoding : utf-8 -*-
class ProductAttributeValue < ActiveRecord::Base
  has_many :product_attributes
  belongs_to :product_attribute_define
  paginates_per 20
end
