# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  validates_presence_of :name, :memo,  :price, :status, :indication_price,  :sku, :count, :sold_count, :cn_name
  validates_numericality_of :price, :indication_price,:count, :sold_count
  validates_uniqueness_of :sku
  has_many :product_attributes
  has_many :product_tags
  cattr_reader :per_page
  paginates_per 20
  has_attached_file :pic_label, :styles => { :medium => "300x300" }
  has_attached_file :pic_main, :styles => { :medium => "270x270", :thumb => "224x224" }
  
  def has_attribute(short,value)
    self.product_attributes.each do | attr |
      if attr.short == short && attr.value == value
        return true
      end
    end
    return false
  end
  
  # TODO: 需要修改成判断多个值的方式
  def get_attribute_value(short)
    value = ''
    self.product_attributes.find_all_by_short(short).each_with_index do | attr , index|
      if index > 0 
        value = value + '，' + attr.value
      else
        value = attr.value
      end 
    end
    
    return value
  end
  
end
