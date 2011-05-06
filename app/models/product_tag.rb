# -*- encoding : utf-8 -*-
class ProductTag < ActiveRecord::Base
  belongs_to :product
end
