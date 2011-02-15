class Product < ActiveRecord::Base
  validates_presence_of :name, :memo,  :price, :status, :indication_price,  :sku, :count, :sold_count, :cn_name, :pic
  validates_numericality_of :price, :indication_price,:count, :sold_count
  validates_uniqueness_of :sku
  has_many :product_attributes, :foreign_key => "product_sku", :primary_key => "sku"
  has_many :product_tags, :foreign_key => "product_sku", :primary_key => "sku"
  cattr_reader :per_page
  @@per_page = 8
  
  def has_attribute(short,value)
    self.product_attributes.each do | attr |
      if attr.short == short && attr.value == value
        return true
      end
    end
    return false
  end
end
