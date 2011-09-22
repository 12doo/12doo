# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  has_many :categories
  belongs_to :category
  has_many :product_attribute_defines
  has_many :product_attribute_values
  has_many :product_attributes
end
