class Product < ActiveRecord::Base
  validates_presence_of :name, :memo, :vintage,  :price, :status, :indication_price,  :sku, :count
  validates_numericality_of :price, :indication_price,:count
  has_many :product_attributes, :foreign_key => "product_sku", :primary_key => "sku"
end
