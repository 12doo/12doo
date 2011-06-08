# -*- encoding : utf-8 -*-
class ProductAttributeDefine < ActiveRecord::Base
  def get_values
    returns = ''
    ProductAttributeValue.where(:name => self.name).order("sort desc").each { |item| returns += item.value + ',' }
    returns
  end
  
  def save_values(values)
    ProductAttributeValue.where(:name => self.name).order("sort desc").each { |item| item.destroy }
    values.split(',').each_with_index do |item, index|
      value = ProductAttributeValue.new
      value.value = item
      value.short = self.short
      value.sort = index
      value.name = self.name
      value.save
    end
  end
end
