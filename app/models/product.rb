class Product < ActiveRecord::Base
  validates_presence_of :name, :memo, :vintage,  :price, :status, :indication_price,  :sku, :count
  validates_numericality_of :price, :indication_price,:count
  has_many :product_attributes, :foreign_key => "product_sku", :primary_key => "sku"
  has_many :product_tags, :foreign_key => "product_sku", :primary_key => "sku"
  cattr_reader :per_page
  @@per_page = 20
end
