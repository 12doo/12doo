class ProductTag < ActiveRecord::Base
  belongs_to :product, :foreign_key => "sku", :primary_key => "product_sku"
end
